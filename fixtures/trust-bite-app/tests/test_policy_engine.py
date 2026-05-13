"""
Unit tests for the policy engine.
"""

import sys
import os

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "src"))

from policy_engine import assess_risk, is_protected_file


def test_assess_risk_small_change():
    change = {
        "file_path": "src/app.py",
        "lines_added": 5,
        "lines_removed": 2,
        "is_new_file": False,
    }
    result = assess_risk(change)
    assert result["risk_level"] == "low"
    assert result["score"] == 15


def test_assess_risk_medium_change():
    change = {
        "file_path": "src/app.py",
        "lines_added": 25,
        "lines_removed": 10,
        "is_new_file": False,
    }
    result = assess_risk(change)
    assert result["risk_level"] == "medium"
    assert result["score"] == 45


def test_assess_risk_large_change():
    change = {
        "file_path": "src/app.py",
        "lines_added": 80,
        "lines_removed": 30,
        "is_new_file": False,
    }
    result = assess_risk(change)
    assert result["risk_level"] == "high"
    assert result["score"] == 80


def test_assess_risk_new_file():
    change = {
        "file_path": "src/new_module.py",
        "lines_added": 200,
        "lines_removed": 0,
        "is_new_file": True,
    }
    result = assess_risk(change)
    assert result["risk_level"] == "low"
    assert result["score"] == 10


def test_assess_risk_invalid_input():
    result = assess_risk("not a dict")
    assert result["risk_level"] == "high"
    assert result["score"] == 100


def test_is_protected_file_exact_match():
    protected = ["src/policy_engine.py", "config/secrets.yml"]
    assert is_protected_file("src/policy_engine.py", protected) is True


def test_is_protected_file_no_match():
    protected = ["src/policy_engine.py", "config/secrets.yml"]
    assert is_protected_file("src/app.py", protected) is False


def test_is_protected_file_prefix_match():
    protected = ["src/policy_engine.py", "config"]
    assert is_protected_file("config/database.yml", protected) is True


def test_is_protected_file_empty_list():
    assert is_protected_file("src/app.py", []) is False


if __name__ == "__main__":
    test_assess_risk_small_change()
    test_assess_risk_medium_change()
    test_assess_risk_large_change()
    test_assess_risk_new_file()
    test_assess_risk_invalid_input()
    test_is_protected_file_exact_match()
    test_is_protected_file_no_match()
    test_is_protected_file_prefix_match()
    test_is_protected_file_empty_list()
    print("All tests passed.")
