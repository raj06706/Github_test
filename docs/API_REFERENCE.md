# Jira Integration API Reference

## Overview

This document provides a reference for the Jira integration API and utility functions.

## JiraGitHubSync Class

### Constructor

```javascript
const JiraGitHubSync = require('./scripts/jira-sync');
const sync = new JiraGitHubSync(config);
```

**Parameters:**
- `config` (Object): Configuration object from `config/jira-config.json`

### Methods

#### extractJiraIssueKey(text)

Extracts Jira issue key from text.

```javascript
const key = sync.extractJiraIssueKey('PROJ-123: New feature');
// Returns: 'PROJ-123'
```

**Parameters:**
- `text` (string): Text to search for issue key

**Returns:**
- (string | null): Jira issue key or null if not found

---

#### makeJiraRequest(method, endpoint, data)

Makes HTTP request to Jira API.

```javascript
const response = await sync.makeJiraRequest('GET', '/issue/PROJ-123');
// Returns: { status: 200, data: {...} }
```

**Parameters:**
- `method` (string): HTTP method (GET, POST, PUT, etc.)
- `endpoint` (string): Jira API endpoint
- `data` (Object, optional): Request body data

**Returns:**
- (Promise): Promise resolving to response object with `status` and `data`

---

#### linkPullRequest(prData)

Links GitHub PR to Jira issue.

```javascript
const prData = {
  number: 42,
  title: 'PROJ-123: Add new feature',
  body: 'This PR implements...',
  html_url: 'https://github.com/...'
};

const result = await sync.linkPullRequest(prData);
// Returns: true on success, false on failure
```

**Parameters:**
- `prData` (Object): GitHub PR data

**Returns:**
- (Promise<boolean>): Success status

---

#### linkIssue(issueData)

Links GitHub issue to Jira.

```javascript
const issueData = {
  number: 10,
  title: 'PROJ-456: Fix bug',
  body: 'This issue is about...',
  html_url: 'https://github.com/...'
};

const result = await sync.linkIssue(issueData);
```

**Parameters:**
- `issueData` (Object): GitHub issue data

**Returns:**
- (Promise<boolean>): Success status

---

#### updateJiraStatus(issueKey, prStatus)

Updates Jira issue status based on PR status.

```javascript
const result = await sync.updateJiraStatus('PROJ-123', 'open');
```

**Parameters:**
- `issueKey` (string): Jira issue key (e.g., 'PROJ-123')
- `prStatus` (string): PR status (open, closed, etc.)

**Returns:**
- (Promise<boolean>): Success status

---

#### addCommentToJira(issueKey, comment, author)

Adds comment to Jira issue from GitHub.

```javascript
const result = await sync.addCommentToJira(
  'PROJ-123',
  'This is a comment from GitHub',
  'john-doe'
);
```

**Parameters:**
- `issueKey` (string): Jira issue key
- `comment` (string): Comment text
- `author` (string): Comment author

**Returns:**
- (Promise<boolean>): Success status

---

## Configuration Reference

### jira-config.json Structure

```json
{
  "jira": {
    "baseUrl": "https://your-domain.atlassian.net",
    "apiVersion": "3",
    "issueKeyPattern": "^[A-Z]+-\\d+$",
    "customFields": {
      "github_pr_url": "customfield_XXXXX",
      "github_issue_url": "customfield_XXXXX",
      "github_branch": "customfield_XXXXX"
    },
    "transitionMap": {
      "open": "To Do",
      "in_progress": "In Progress",
      "review": "In Review",
      "closed": "Done"
    }
  },
  "github": {
    "owner": "raj06706",
    "repo": "Github_test",
    "autoLink": true,
    "autoComment": true,
    "autoLabel": true
  },
  "sync": {
    "enabled": true,
    "interval": 3600,
    "bidirectional": true,
    "syncComments": true,
    "syncStatus": true
  }
}
```

## Environment Variables

```
JIRA_BASE_URL           - Jira instance URL
JIRA_API_TOKEN          - Jira API token
JIRA_USER_EMAIL         - Jira user email
GITHUB_TOKEN            - GitHub personal access token
GITHUB_OWNER            - GitHub repository owner
GITHUB_REPO             - GitHub repository name
SYNC_ENABLED            - Enable sync (true/false)
SYNC_INTERVAL           - Sync interval in seconds
BIDIRECTIONAL_SYNC      - Enable bidirectional sync
```

## Error Handling

All methods return promises and may throw errors. Wrap calls in try-catch:

```javascript
try {
  const result = await sync.linkPullRequest(prData);
  if (result) {
    console.log('Successfully linked PR');
  }
} catch (error) {
  console.error('Error linking PR:', error.message);
}
```

## Examples

### Example 1: Sync PR to Jira

```javascript
const JiraGitHubSync = require('./scripts/jira-sync');
const config = require('./config/jira-config.json');

const sync = new JiraGitHubSync(config);

const prData = {
  number: 1,
  title: '[PROJ-123] New feature',
  body: 'Implement new dashboard',
  html_url: 'https://github.com/raj06706/Github_test/pull/1'
};

sync.linkPullRequest(prData)
  .then(success => {
    if (success) console.log('PR linked successfully');
  })
  .catch(error => console.error('Error:', error));
```

### Example 2: Update Issue Status

```javascript
sync.updateJiraStatus('PROJ-123', 'closed')
  .then(success => {
    if (success) console.log('Status updated');
  })
  .catch(error => console.error('Error:', error));
```

---

For more information, see [JIRA_INTEGRATION_SETUP.md](docs/JIRA_INTEGRATION_SETUP.md)
