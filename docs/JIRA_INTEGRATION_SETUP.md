# GitHub-Jira Integration Setup Guide

This guide will help you set up the GitHub-Jira integration for the Github_test repository.

## Prerequisites

- Jira Cloud account or Jira Server/Data Center instance
- GitHub repository with admin access
- API tokens/credentials from both platforms

## Setup Steps

### 1. Generate Jira API Token

1. Log in to your Jira account
2. Go to https://id.atlassian.com/manage-profile/security/api-tokens
3. Click "Create API token"
4. Copy the token (you'll use it later)

### 2. Generate GitHub Personal Access Token

1. Go to GitHub Settings → Developer settings → Personal access tokens
2. Click "Generate new token"
3. Select scopes: `repo`, `read:org`, `workflow`
4. Copy the token

### 3. Add GitHub Secrets

In your GitHub repository:

1. Go to Settings → Secrets and variables → Actions
2. Add the following secrets:

| Secret Name | Value |
|-------------|-------|
| `JIRA_BASE_URL` | `https://your-domain.atlassian.net` |
| `JIRA_API_TOKEN` | Your Jira API token |
| `JIRA_USER_EMAIL` | Your Jira account email |
| `GITHUB_TOKEN` | Your GitHub personal access token |

### 4. Configure Custom Fields in Jira

Add custom fields to track GitHub links:

1. In Jira, go to Settings → Issues → Custom fields
2. Create the following custom fields:
   - **GitHub PR URL** (Text field) - Store PR links
   - **GitHub Issue URL** (Text field) - Store GitHub issue links
   - **GitHub Branch** (Text field) - Store branch names

3. Update `config/jira-config.json` with the custom field IDs:
   ```json
   "customFields": {
     "github_pr_url": "customfield_XXXXX",
     "github_issue_url": "customfield_XXXXX",
     "github_branch": "customfield_XXXXX"
   }
   ```

### 5. Link Jira Issues in GitHub

To link a Jira issue to a GitHub PR or issue, include the issue key in:
- PR title: `[PROJ-123] Add new feature`
- PR description: `Fixes PROJ-123`
- Branch name: `PROJ-123-feature-name`
- Issue title: `PROJ-456: Bug fix needed`

## Features

### Automatic PR Linking
When you create a PR with a Jira issue key in the title or description, the integration will:
- Link the PR to the Jira issue
- Update custom fields with the PR URL
- Add comments to the Jira issue

### Status Synchronization
PR statuses are automatically synced to Jira:
- PR opened → Issue moves to "In Progress"
- PR under review → Issue moves to "In Review"
- PR closed → Issue moves to "Done"

### Comment Sync
Comments from GitHub PRs are synced to Jira issues automatically.

## Usage Examples

### Example 1: Create a PR linked to Jira
```bash
git checkout -b PROJ-123-new-feature
# Make changes
git push origin PROJ-123-new-feature
```

Create PR with title: `[PROJ-123] Implement new feature`

### Example 2: Reference Jira in PR description
```markdown
## Description
This PR implements the new dashboard feature.

## Jira Issue
Fixes PROJ-456

## Changes
- Added new dashboard component
- Updated styles
```

## Troubleshooting

### Integration not working?

1. **Check API credentials**
   - Verify tokens in GitHub Secrets
   - Ensure Jira API token is valid and not expired

2. **Check workflow logs**
   - Go to Actions tab in GitHub
   - Look for failed workflow runs
   - Check error messages in logs

3. **Verify Jira issue key format**
   - Format should be `PROJECT-123` (uppercase)
   - Check your Jira project key is correct

4. **Custom field IDs**
   - Verify custom field IDs in `jira-config.json`
   - Custom field IDs are unique per Jira instance

### Testing the integration

```bash
# Run the sync script manually
node scripts/jira-sync.js

# Check for errors
npm run test:jira-integration
```

## Advanced Configuration

### Customize transition mapping

Edit `config/jira-config.json` to map statuses:
```json
"transitionMap": {
  "open": "To Do",
  "in_progress": "In Progress",
  "review": "In Review",
  "closed": "Done"
}
```

### Enable bidirectional sync

Set in `.env`:
```
BIDIRECTIONAL_SYNC=true
```

This allows Jira status changes to update GitHub PR labels.

## Support

For issues or questions:
1. Check the workflow logs in GitHub Actions
2. Review Jira API documentation
3. Verify all credentials are correct
4. Check custom field configurations

## References

- [Jira API Documentation](https://developer.atlassian.com/cloud/jira/rest/v3/)
- [GitHub API Documentation](https://docs.github.com/en/rest)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
