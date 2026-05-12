/**
 * API module — route definitions.
 * Cross-module dependency: imports from auth for session validation.
 */

import { getSession, isExpired } from "../auth/session.js";

export interface ApiRequest {
  path: string;
  method: string;
  sessionId?: string;
}

export interface ApiResponse {
  status: number;
  body: unknown;
}

export function handleRequest(req: ApiRequest): ApiResponse {
  // Public routes
  if (req.path === "/health") {
    return { status: 200, body: { ok: true } };
  }

  // Protected routes require valid session
  if (!req.sessionId) {
    return { status: 401, body: { error: "No session" } };
  }

  const session = getSession(req.sessionId);
  if (!session) {
    return { status: 401, body: { error: "Invalid session" } };
  }

  if (isExpired(session)) {
    return { status: 401, body: { error: "Session expired" } };
  }

  // Route dispatch
  if (req.path === "/billing/usage") {
    return { status: 200, body: { usage: [] } };
  }

  return { status: 404, body: { error: "Not found" } };
}
