"""
Simple application logic that uses the policy engine.
"""

from policy_engine import assess_risk, is_protected_file


PROTECTED_PATHS = [
    "src/policy_engine.py",
]


def evaluate_changes(changes: list) -> dict:
    """
    Evaluate a list of changes and produce a summary.

    Args:
        changes: List of change dictionaries

    Returns:
        Summary dictionary with overall risk and per-file results
    """
    results = []
    highest_risk = "low"
    risk_order = {"low": 0, "medium": 1, "high": 2}

    for change in changes:
        file_path = change.get("file_path", "")
        risk = assess_risk(change)
        protected = is_protected_file(file_path, PROTECTED_PATHS)

        result = {
            "file_path": file_path,
            "risk": risk,
            "protected": protected,
        }
        results.append(result)

        if risk_order.get(risk["risk_level"], 0) > risk_order.get(highest_risk, 0):
            highest_risk = risk["risk_level"]

    return {
        "overall_risk": highest_risk,
        "file_count": len(changes),
        "results": results,
    }


if __name__ == "__main__":
    sample_changes = [
        {
            "file_path": "src/app.py",
            "lines_added": 5,
            "lines_removed": 2,
            "is_new_file": False,
        },
        {
            "file_path": "src/policy_engine.py",
            "lines_added": 10,
            "lines_removed": 3,
            "is_new_file": False,
        },
    ]

    summary = evaluate_changes(sample_changes)
    print(f"Overall risk: {summary['overall_risk']}")
    for r in summary["results"]:
        status = " [PROTECTED]" if r["protected"] else ""
        print(f"  {r['file_path']}: {r['risk']['risk_level']}{status}")
