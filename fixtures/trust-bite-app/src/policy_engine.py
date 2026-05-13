"""
Policy Engine — deterministic risk decision function.

This module is PROTECTED by governance rules in pantheon.json.
Any modification to this file triggers a non-pass governance verdict.
"""


def assess_risk(change: dict) -> dict:
    """
    Assess the risk level of a proposed change.

    Args:
        change: A dictionary with keys:
            - file_path (str): Path to the changed file
            - lines_added (int): Number of lines added
            - lines_removed (int): Number of lines removed
            - is_new_file (bool): Whether this is a new file

    Returns:
        A dictionary with keys:
            - risk_level (str): "low", "medium", or "high"
            - reason (str): Human-readable explanation
            - score (int): Numeric risk score 0-100
    """
    if not isinstance(change, dict):
        return {
            "risk_level": "high",
            "reason": "Invalid change format",
            "score": 100,
        }

    lines_added = change.get("lines_added", 0)
    lines_removed = change.get("lines_removed", 0)
    is_new_file = change.get("is_new_file", False)

    total_delta = lines_added + lines_removed

    if is_new_file:
        return {
            "risk_level": "low",
            "reason": "New file addition",
            "score": 10,
        }

    if total_delta > 100:
        return {
            "risk_level": "high",
            "reason": f"Large change: {total_delta} lines modified",
            "score": 80,
        }

    if total_delta > 30:
        return {
            "risk_level": "medium",
            "reason": f"Moderate change: {total_delta} lines modified",
            "score": 45,
        }

    return {
        "risk_level": "low",
        "reason": f"Small change: {total_delta} lines modified",
        "score": 15,
    }


def is_protected_file(file_path: str, protected_paths: list) -> bool:
    """
    Check if a file path matches any protected path pattern.

    Args:
        file_path: The file path to check
        protected_paths: List of protected path strings

    Returns:
        True if the file is protected, False otherwise
    """
    for protected in protected_paths:
        if file_path == protected or file_path.startswith(protected + "/"):
            return True
    return False
