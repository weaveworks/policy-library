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
	PolicyPath   string
)

const PolicyQuery = "violation"

type PolicyMetadata struct {
	Spec struct {
		ID         string 				    `yaml:"id"`
		Name       string 				    `yaml:"name"`
		Parameters []map[string]interface{} `yaml:"parameters"`
	} `yaml:"spec"`
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

func getRegoPolicy(path string) (*opa.Policy, error) {
	regoPath := fmt.Sprintf("%s/policy.rego", path)
	if !pathExists(regoPath) {
		return nil, fmt.Errorf("Failed to find rego code file.")
	}
	code, err := ioutil.ReadFile(regoPath)
	if err != nil {
		return nil, fmt.Errorf("Failed to read rego code: %w", err)
	}

	policy, err := opa.Parse(string(code), PolicyQuery)
	if err != nil {
		return nil, fmt.Errorf("Failed to parse policy rego code: %w", err)
	}
	return &policy, nil
}

func getTestCases(testsDir string) ([]map[string]interface{}, error) {
	testFiles, err := ioutil.ReadDir(testsDir)
	if err != nil {
		return nil, fmt.Errorf("Failed to list tests in %s: %w", testsDir, err)
	}
	var testCases []map[string]interface{}

	for _, f := range testFiles {
		var testCase map[string]interface{}
		err = parseYamlFile(fmt.Sprintf("%s/%s", testsDir, f.Name()), &testCase)

		if err != nil {
			return nil, fmt.Errorf("Failed to load test case %s/%s: %w", testsDir, f.Name(), err)
		}
		testCases = append(testCases, testCase)
	}
	return testCases, nil
}

func TestPolicy(path string) error {
	policyName := filepath.Base(path)
	testsDir := fmt.Sprintf("%s/tests", path)
	if !pathExists(testsDir) {
		return nil
	}
	log.Printf("Testing %s policy", policyName)

	regoPolicy, err := getRegoPolicy(path)
	if err != nil {
		return err
	}

	testCases, err := getTestCases(testsDir)
	if err != nil {
		return nil
	}

	var policyMetadata PolicyMetadata
	err = parseYamlFile(fmt.Sprintf("%s/policy.yaml", path), &policyMetadata)
	if err != nil {
		return fmt.Errorf("Failed to load %s policy yaml: %w", path, err)
	}

	params := make(map[string]interface{})
	for _, param := range policyMetadata.Spec.Parameters{
		params[param["name"].(string)] = param["default"] 
    }

	for i := range testCases {
		testCase := testCases[i]
		err = regoPolicy.EvalGateKeeperCompliant(testCase, params, PolicyQuery)
		if err != nil {
			return fmt.Errorf("Testing %s policy failed: %w", policyName, err)
		}
	}
	return nil
}

func TestPolicies(rootDir string) error {
	policyDirs, err := ioutil.ReadDir(rootDir)
	if err != nil {
		return fmt.Errorf("Failed to list policies in %s: %w", rootDir, err)
	}

	hasError := false
	for _, policyDir := range policyDirs {
		if policyDir.IsDir() {
			err := TestPolicy(fmt.Sprintf("%s/%s", rootDir, policyDir.Name()))
			if err != nil {
				log.Println(err)
				hasError = true
			}
		}
	}

	if hasError {
		return fmt.Errorf("Testing policies failed")
	}
	return nil
}

func main() {
	app := cli.NewApp()
	app.Version = "0.0.1"
	app.Name = "policies test"
	app.Usage = "Test policy code"
	app.Flags = []cli.Flag{
		&cli.StringFlag{
			Name:        "root-dir",
			Usage:       "Root directory containing all policies directories",
			Destination: &RootDir,
			Value:       "",
		},
		&cli.StringFlag{
			Name:        "policy-path",
			Usage:       "Path to policy dir",
			Destination: &PolicyPath,
			Value:       "",
		},
	}
	app.Before = func(context *cli.Context) error {
		if RootDir != "" && PolicyPath != "" {
			return fmt.Errorf("Please set only one of `root-dir` and `policy-path`")
		}
		for _, path := range []string{RootDir, PolicyPath} {
			if path != "" && !pathExists(path) {
				return fmt.Errorf("Path: %s, does not exist", path)
			}
		}
		return nil
	}
	app.Action = func(ctx *cli.Context) error {
		if PolicyPath != "" {
			err := TestPolicy(PolicyPath)
			if err != nil {
				return err
			}
		}
		if RootDir != "" {
			err := TestPolicies((RootDir))
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
