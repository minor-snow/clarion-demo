/**
 * Billing module — usage tracking.
 * Tracks API usage per user for billing purposes.
 */

export interface UsageRecord {
  userId: string;
  endpoint: string;
  timestamp: number;
  cost: number;
}

const usageLog: UsageRecord[] = [];

export function recordUsage(userId: string, endpoint: string): void {
  usageLog.push({
    userId,
    endpoint,
    timestamp: Date.now(),
    cost: calculateCost(endpoint),
  });
}

export function getUsage(userId: string): UsageRecord[] {
  return usageLog.filter((r) => r.userId === userId);
}

function calculateCost(endpoint: string): number {
  // Simple cost model for demo
  if (endpoint.startsWith("/billing")) return 0;
  if (endpoint.startsWith("/api")) return 0.01;
  return 0.001;
}
