"""
LLM Adapter — interface to language model providers.

This module is REVIEW-REQUIRED by governance rules in pantheon.json.
Any modification to this file triggers a requires_review governance state,
meaning a human must acknowledge the change before it merges.
"""

# Supported providers
PROVIDERS = ["openai", "anthropic", "local"]

# Default configuration
DEFAULT_PROVIDER = "local"
DEFAULT_TIMEOUT = 30
MAX_RETRIES = 3


def get_provider_config(provider: str) -> dict:
    """
    Return configuration for the specified LLM provider.

    Args:
        provider: One of "openai", "anthropic", or "local"

    Returns:
        A dictionary with provider-specific configuration.
    """
    if provider not in PROVIDERS:
        return {
            "error": f"Unknown provider: {provider}",
            "valid": False,
        }

    configs = {
        "openai": {
            "endpoint": "https://api.openai.com/v1",
            "timeout": DEFAULT_TIMEOUT,
            "max_retries": MAX_RETRIES,
            "requires_api_key": True,
            "valid": True,
        },
        "anthropic": {
            "endpoint": "https://api.anthropic.com/v1",
            "timeout": DEFAULT_TIMEOUT,
            "max_retries": MAX_RETRIES,
            "requires_api_key": True,
            "valid": True,
        },
        "local": {
            "endpoint": "http://localhost:11434",
            "timeout": DEFAULT_TIMEOUT * 2,
            "max_retries": 1,
            "requires_api_key": False,
            "valid": True,
        },
    }

    return configs[provider]


def validate_adapter_change(old_config: dict, new_config: dict) -> dict:
    """
    Validate that a proposed adapter configuration change is safe.

    Args:
        old_config: The current adapter configuration
        new_config: The proposed new configuration

    Returns:
        A dictionary with validation result:
            - safe (bool): Whether the change is considered safe
            - reason (str): Explanation
            - requires_review (bool): Whether human review is needed
    """
    if not isinstance(old_config, dict) or not isinstance(new_config, dict):
        return {
            "safe": False,
            "reason": "Invalid configuration format",
            "requires_review": True,
        }

    # Endpoint changes always require review
    if old_config.get("endpoint") != new_config.get("endpoint"):
        return {
            "safe": True,
            "reason": "Endpoint change detected — human review required",
            "requires_review": True,
        }

    # Timeout increases are safe
    old_timeout = old_config.get("timeout", DEFAULT_TIMEOUT)
    new_timeout = new_config.get("timeout", DEFAULT_TIMEOUT)
    if new_timeout > old_timeout:
        return {
            "safe": True,
            "reason": "Timeout increased — generally safe",
            "requires_review": False,
        }

    # Retry count changes require review
    if old_config.get("max_retries") != new_config.get("max_retries"):
        return {
            "safe": True,
            "reason": "Retry policy change — human review recommended",
            "requires_review": True,
        }

    return {
        "safe": True,
        "reason": "No significant changes detected",
        "requires_review": False,
    }
