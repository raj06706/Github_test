# Contributing to Github_test

## Jira Integration Guidelines

When working with Jira integration, follow these guidelines:

### Naming Conventions

- Include Jira issue keys in PR titles and branch names
- Format: `[PROJ-123] Description of changes`

### Branch Naming

```bash
git checkout -b PROJ-123-feature-description
```

### Commit Messages

Include the Jira issue key in commit messages:
```
[PROJ-123] Implement new authentication

This commit adds OAuth2 authentication support
```

### Pull Request Template

```markdown
## Description
Brief description of changes

## Jira Issue
- Fixes PROJ-123

## Changes
- Change 1
- Change 2

## Testing
How to test these changes
```

### Linking to Jira

The integration will automatically link your PR if it contains:
1. Issue key in PR title: `[PROJ-123]`
2. Issue key in PR description: `Fixes PROJ-123`
3. Issue key in branch name: `PROJ-123-feature`

### Code Review Process

1. Create a PR with Jira issue key
2. Wait for automated Jira linking
3. Request review from team members
4. Address feedback
5. Merge PR (PR will automatically update Jira status)

## Setting Up Development Environment

```bash
# Clone repository
git clone https://github.com/raj06706/Github_test.git
cd Github_test

# Install dependencies
npm install

# Create .env file
cp .env.example .env

# Add your credentials to .env
# Run tests
npm test
```

## Reporting Issues

When reporting issues, include:
- Description of the problem
- Steps to reproduce
- Expected behavior
- Actual behavior
- Screenshots (if applicable)

Create GitHub issue and link to Jira if applicable.
