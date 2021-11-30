package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"

	opa "github.com/MagalixTechnologies/opa-core"
	"github.com/ghodss/yaml"
	"github.com/urfave/cli/v2"
)

var (
	RootDir      string
	TemplatePath string
)

const PolicyQuery = "violation"

type Constraint struct {
	Sync       bool                   `yaml:"sync"`
	Name       string                 `yaml:"name"`
	Parameters map[string]interface{} `yaml:"parameters"`
}

func pathExists(path string) bool {
	_, err := os.Stat(path)
	return !os.IsNotExist(err)
}

func parseYamlFile(path string, obj interface{}) error {
	t, err := ioutil.ReadFile(path)
	if err != nil {
		return err
	}
	err = yaml.Unmarshal(t, obj)
	if err != nil {
		return err
	}
	return nil
}

func getPolicyTemplate(path string) (*opa.Policy, error) {
	codePath := fmt.Sprintf("%s/template/template.rego", path)
	if !pathExists(codePath) {
		return nil, fmt.Errorf("failed to find template code file")
	}
	code, err := ioutil.ReadFile(fmt.Sprintf("%s/template/template.rego", path))
	if err != nil {
		return nil, fmt.Errorf("failed to read rego code. %w", err)
	}

	policy, err := opa.Parse(string(code), PolicyQuery)
	if err != nil {
		return nil, fmt.Errorf("failed to parse template code. %w", err)
	}
	return &policy, nil
}

func getTestCases(testsDir string) ([]map[string]interface{}, error) {
	testFiles, err := ioutil.ReadDir(testsDir)
	if err != nil {
		return nil, fmt.Errorf("failed to list tests in path: %s. %w", testsDir, err)
	}
	var testCases []map[string]interface{}

	for _, f := range testFiles {
		var testCase map[string]interface{}
		err = parseYamlFile(fmt.Sprintf("%s/%s", testsDir, f.Name()), &testCase)

		if err != nil {
			return nil, fmt.Errorf("failed to load test case yaml. %w", err)
		}
		testCases = append(testCases, testCase)

	}
	return testCases, nil
}

func TestTemplate(path string) error {
	templateName := filepath.Base(path)
	testsDir := fmt.Sprintf("%s/tests", path)
	constraintsDir := fmt.Sprintf("%s/constraints", path)
	if !pathExists(testsDir) || !pathExists(constraintsDir) {
		return nil
	}
	log.Printf("Testing template %s", templateName)

	policyTemplate, err := getPolicyTemplate(path)
	if err != nil {
		return err
	}

	testCases, err := getTestCases(testsDir)
	if err != nil {
		return nil
	}

	constrainFiles, err := ioutil.ReadDir(constraintsDir)
	if err != nil {
		return fmt.Errorf("failed to list constraints in path: %s. %w", path, err)
	}

	for _, f := range constrainFiles {
		if filepath.Ext(f.Name()) == ".yaml" {
			var constraint Constraint
			err = parseYamlFile(fmt.Sprintf("%s/%s", constraintsDir, f.Name()), &constraint)
			if err != nil {
				return fmt.Errorf("failed to load constraint yaml. %w", err)
			}
			if constraint.Sync {
				for i := range testCases {
					testCase := testCases[i]
					err = policyTemplate.EvalGateKeeperCompliant(testCase, constraint.Parameters, PolicyQuery)
					if err != nil {
						return fmt.Errorf("testing template: %s, constraint: %s failed. %w", templateName, constraint.Name, err)
					}
				}
			}
		}

	}
	return nil

}

func TestTemplates(rootDir string) error {
	templateDirs, err := ioutil.ReadDir(rootDir)
	if err != nil {
		return fmt.Errorf("failed to list templates in path: %s. %w", rootDir, err)
	}
	hasError := false
	for _, templateDir := range templateDirs {
		if templateDir.IsDir() {
			err := TestTemplate(fmt.Sprintf("%s/%s", rootDir, templateDir.Name()))
			if err != nil {
				log.Println(err)
				hasError = true
			}
		}
	}
	if hasError {
		return fmt.Errorf("testing constraints failed")
	}
	return nil
}

func main() {
	app := cli.NewApp()
	app.Version = "0.0.1"
	app.Name = "policies test"
	app.Usage = "Test policy template code"
	app.Flags = []cli.Flag{
		&cli.StringFlag{
			Name:        "root-dir",
			Usage:       "Root directory containing all template directories",
			Destination: &RootDir,
			Value:       "",
		},
		&cli.StringFlag{
			Name:        "template-path",
			Usage:       "path to template dir",
			Destination: &TemplatePath,
			Value:       "",
		},
	}
	app.Before = func(context *cli.Context) error {
		if RootDir != "" && TemplatePath != "" {
			return fmt.Errorf("Please set only one of `root-dir` and `template-path`")
		}
		for _, path := range []string{RootDir, TemplatePath} {
			if path != "" && !pathExists(path) {
				return fmt.Errorf("path: %s, does not exist", path)
			}
		}
		return nil
	}
	app.Action = func(ctx *cli.Context) error {
		if TemplatePath != "" {
			err := TestTemplate(TemplatePath)
			if err != nil {
				return err
			}
		}
		if RootDir != "" {
			err := TestTemplates((RootDir))
			if err != nil {
				return err
			}
		}
		return nil
	}
	err := app.Run(os.Args)
	if err != nil {
		log.Fatal(err)
	}

}
