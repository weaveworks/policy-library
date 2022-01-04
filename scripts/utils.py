
def is_equal(local, remote):
    if type(local) != type(remote):
        return False

    if isinstance(local, str):
        return local.strip() == remote.strip()
    elif isinstance(local, (int, float, bool)):
        return local == remote
    elif isinstance(local, (list, tuple, set)):
        if len(local) != len(remote):
            return False
        for item in local:
            if item not in remote:
                return False
        else:
            return True
    elif isinstance(local, dict):
        if len(local) != len(remote):
            return False
        for key, value in local.items():
            if remote.get(key) != value:
                return False
        else:
            return True
