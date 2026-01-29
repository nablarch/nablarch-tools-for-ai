#!/bin/bash

# プロジェクト名を取得
PROJECT_NAME=$(basename "$CLAUDE_PROJECT_DIR")

# ブランチ名を取得
BRANCH_NAME=$(git -C "$CLAUDE_PROJECT_DIR" branch --show-current 2>/dev/null || echo "unknown")

# PowerShell通知を実行
powershell.exe -Command "
  Add-Type -AssemblyName System.Windows.Forms;
  Add-Type -AssemblyName System.Drawing;
  \$notification = New-Object System.Windows.Forms.NotifyIcon;
  \$notification.Icon = [System.Drawing.SystemIcons]::Information;
  \$notification.BalloonTipTitle = 'Claude Code - $PROJECT_NAME';
  \$notification.BalloonTipText = '$BRANCH_NAME: Ready!';
  \$notification.Visible = \$true;
  \$notification.ShowBalloonTip(5000);
  Start-Sleep -Seconds 5;
  \$notification.Dispose()
"
