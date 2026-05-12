# Clarion Demo — Guided 10-Minute Walkthrough (Windows)
$ErrorActionPreference = "Stop"

$DemoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$FixtureDir = Join-Path $DemoRoot "fixtures\demo-app"
$EnvelopeDir = Join-Path $DemoRoot "envelopes"

if ($env:CLARION_BIN) {
    $ClarionBin = $env:CLARION_BIN
} else {
    $ClarionBin = "clarion"
}

function Run-Clarion { param([string[]]$Args) & node $ClarionBin @Args 2>$null }

Set-Location $FixtureDir

Write-Host ""
Write-Host "  Clarion Demo - Governed AI Change in 10 Minutes" -ForegroundColor Cyan
Write-Host ""

# Step 1
Write-Host "  Step 1/5: Observe the repository structure" -ForegroundColor Yellow
Run-Clarion "dsa","observe","--repo",".","--json" | Out-Null
Write-Host "  Done - Architecture observed" -ForegroundColor Green
Read-Host "  Press Enter to continue"

# Step 2
Write-Host "  Step 2/5: Import architecture-backed work items" -ForegroundColor Yellow
Run-Clarion "workgraph","import-dsa","--actor","demo-operator","--repo",".","--json" | Out-Null
Write-Host "  Done - Work items created" -ForegroundColor Green
Read-Host "  Press Enter to continue"

# Step 3
Write-Host "  Step 3/5: Submit and complete one agent task" -ForegroundColor Yellow
Run-Clarion "agent","submit","--envelope","@$EnvelopeDir\submit.json","--repo",".","--json" | Out-Null
Run-Clarion "agent","progress","--envelope","@$EnvelopeDir\progress.json","--repo",".","--json" | Out-Null
Run-Clarion "agent","complete","--envelope","@$EnvelopeDir\complete.json","--repo",".","--json" | Out-Null
Write-Host "  Done - Agent lifecycle complete" -ForegroundColor Green
Read-Host "  Press Enter to continue"

# Step 4
Write-Host "  Step 4/5: Show route recommendation" -ForegroundColor Yellow
Run-Clarion "workgraph","list","--status","open","--repo",".","--json" | Out-Null
Write-Host "  Done - Routing is deterministic and explainable" -ForegroundColor Green
Read-Host "  Press Enter to continue"

# Step 5
Write-Host "  Step 5/5: Inspect the final transcript" -ForegroundColor Yellow
Run-Clarion "workgraph","events","--repo",".","--json" | Out-Null
Write-Host "  Done - Full audit trail recorded" -ForegroundColor Green

Write-Host ""
Write-Host "  Demo Complete!" -ForegroundColor Cyan
Write-Host "  Clarion: governance over the process, not just execution." -ForegroundColor White
Write-Host ""
