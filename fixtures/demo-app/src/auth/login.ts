/**
 * Authentication module — login flow.
 * Handles user credential validation and session creation.
 */

export interface LoginCredentials {
  username: string;
  password: string;
}

export interface LoginResult {
  success: boolean;
  sessionId?: string;
  error?: string;
}

export function login(credentials: LoginCredentials): LoginResult {
  if (!credentials.username || !credentials.password) {
    return { success: false, error: "Missing credentials" };
  }

  // Simplified validation for demo
  const sessionId = `sess_${Date.now().toString(36)}`;
  return { success: true, sessionId };
}

export function validateSession(sessionId: string): boolean {
  return sessionId.startsWith("sess_");
}
