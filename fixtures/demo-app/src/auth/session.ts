/**
 * Authentication module — session management.
 * Manages active sessions and expiration.
 */

import { validateSession } from "./login.js";

export interface Session {
  id: string;
  userId: string;
  createdAt: number;
  expiresAt: number;
}

const sessions = new Map<string, Session>();

export function createSession(userId: string): Session {
  const session: Session = {
    id: `sess_${Date.now().toString(36)}`,
    userId,
    createdAt: Date.now(),
    expiresAt: Date.now() + 3600_000, // 1 hour
  };
  sessions.set(session.id, session);
  return session;
}

export function getSession(sessionId: string): Session | undefined {
  if (!validateSession(sessionId)) return undefined;
  return sessions.get(sessionId);
}

export function isExpired(session: Session): boolean {
  return Date.now() > session.expiresAt;
}
