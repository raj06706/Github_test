# Github_test - GitHub-Jira Integration

This repository includes a complete GitHub-Jira integration setup for seamless synchronization between GitHub and Jira.

## Quick Start

1. **Copy environment template**
   ```bash
   cp .env.example .env
   ```

2. **Update `.env` with your credentials**
   - Add your Jira base URL
   - Add your Jira API token
   - Add your Jira user email

3. **Add GitHub Secrets** (see [Setup Guide](docs/JIRA_INTEGRATION_SETUP.md))

4. **Update configuration**
   - Edit `config/jira-config.json` with your Jira custom field IDs
   - Customize transition mappings if needed

## File Structure

```
├── .github/
│   └── workflows/
│       └── jira-integration.yml       # GitHub Actions workflow
├── config/
│   └── jira-config.json               # Integration configuration
├── scripts/
│   └── jira-sync.js                   # Sync utility script
├── docs/
│   └── JIRA_INTEGRATION_SETUP.md      # Setup documentation
├── .env.example                       # Environment variables template
├── package.json                       # Node.js dependencies
└── README.md                          # This file
```

## Features

✅ **Automatic PR Linking** - PRs with Jira issue keys are automatically linked  
✅ **Status Synchronization** - PR statuses sync to Jira workflow  
✅ **Comment Sync** - GitHub comments are mirrored to Jira  
✅ **Custom Field Updates** - GitHub URLs stored in Jira custom fields  
✅ **Workflow Automation** - Automated via GitHub Actions

## How It Works

1. **PR/Issue Created** → Jira issue key detected in title/branch/description
2. **Automatic Link** → Custom fields updated with GitHub URL
3. **Status Change** → Jira issue status updates based on PR status
4. **Comment Added** → GitHub comments synced to Jira issue
5. **Two-way sync** → Optional bidirectional synchronization

## Usage Example

Create a branch with your Jira issue key:
```bash
git checkout -b PROJ-123-new-feature
```

Create a PR with the issue key in the title:
```
[PROJ-123] Implement new authentication system
```

The integration will automatically:
- Link the PR to Jira issue PROJ-123
- Update the GitHub PR URL custom field in Jira
- Monitor the PR status and update Jira accordingly

## Configuration

See [JIRA_INTEGRATION_SETUP.md](docs/JIRA_INTEGRATION_SETUP.md) for detailed setup instructions.

### Key Configuration Files

- **`.github/workflows/jira-integration.yml`** - GitHub Actions workflow
- **`config/jira-config.json`** - Jira integration settings
- **`.env`** - Credentials and API tokens (local only, not committed)

## Requirements

- Node.js 14+ (for running scripts locally)
- Jira Cloud or Server/Data Center instance
- GitHub repository with admin access
- Jira and GitHub API tokens

## Installation

```bash
# Install dependencies
npm install

# Run sync manually (if needed)
npm run sync
```

## Testing

```bash
npm run test:jira-integration
```

## Troubleshooting

- Check GitHub Actions workflow logs for errors
- Verify API tokens in GitHub Secrets
- Ensure Jira custom fields are created and IDs are correct
- Check Jira issue key format (e.g., PROJ-123)

For detailed troubleshooting, see [JIRA_INTEGRATION_SETUP.md](docs/JIRA_INTEGRATION_SETUP.md#troubleshooting)

## License

MIT

## Support

For issues or questions, check the documentation or review workflow logs in GitHub Actions.
