# GitHub Project Setup Guide - RK Groups Website

This guide provides step-by-step instructions for creating and configuring a comprehensive GitHub Project board for managing the RK Groups website development and maintenance.

---

## 🎯 Project Overview

### Project Goals
- **Centralized Task Management** - Track all website development, content updates, and maintenance tasks
- **Automated Workflows** - Streamline issue management with automated state transitions
- **Team Collaboration** - Provide clear visibility into project progress and responsibilities
- **Release Planning** - Organize work into sprints and releases for structured development

### Project Structure
The GitHub Project will include the following key areas:
- **Development Tasks** - Feature development, bug fixes, and technical improvements
- **Content Management** - Company additions, content updates, and policy maintenance
- **Performance & Quality** - SEO optimization, accessibility improvements, and performance monitoring
- **Documentation** - Wiki updates, process documentation, and user guides

---

## 🚀 Step 1: Create GitHub Project

### 1.1 Navigate to GitHub Projects
1. Go to your repository: `https://github.com/rk-Groups/rk-Groups.github.io`
2. Click on the **"Projects"** tab
3. Click **"Link a project"** or **"New project"**
4. Select **"Create a project"**

### 1.2 Project Configuration
**Project Details:**
- **Project Name**: `RK Groups Website Development`
- **Description**: `Comprehensive project management for the RK Groups multi-company Jekyll website including development, content management, performance optimization, and maintenance tasks.`
- **Visibility**: `Private` (recommended for business use)
- **Template**: `Start from scratch` or `Team backlog`

---

## 📋 Step 2: Configure Project Fields

### 2.1 Standard Fields
Set up these custom fields for comprehensive project tracking:

#### **Status Field** (Single Select)
- `📋 Backlog` - Tasks identified but not yet planned
- `🔄 Todo` - Planned tasks ready to start
- `🚧 In Progress` - Currently being worked on
- `👀 In Review` - Under code review or testing
- `✅ Done` - Completed and deployed
- `🚫 Cancelled` - Tasks that are no longer needed

#### **Priority Field** (Single Select)
- `🔴 Critical` - Security issues, site down, critical bugs
- `🟠 High` - Important features, performance issues
- `🟡 Medium` - Standard development tasks
- `🟢 Low` - Nice-to-have features, documentation
- `⚪ Planning` - Research and planning tasks

#### **Type Field** (Single Select)
- `🐛 Bug` - Bug fixes and error corrections
- `✨ Feature` - New features and enhancements
- `📝 Content` - Content updates and company additions
- `🔧 Maintenance` - Regular maintenance and updates
- `📚 Documentation` - Documentation and process updates
- `🏗️ Infrastructure` - Build, deployment, and tooling
- `🎨 Design` - UI/UX improvements and styling

#### **Component Field** (Single Select)
- `🏠 Homepage` - Main landing page
- `🏢 Companies` - Company pages and profiles
- `🧮 Calculators` - Calculator features and functionality
- `📊 Visualizations` - 3D neural network, radial views, dashboards
- `🎨 UI/UX` - Design system and user interface
- `🔧 Build System` - Jekyll, testing, deployment
- `📱 Mobile` - Mobile responsiveness and PWA features
- `♿ Accessibility` - A11y improvements and WCAG compliance
- `🔍 SEO` - Search optimization and analytics

#### **Effort Field** (Single Select)
- `XS` - < 2 hours (small fixes, minor updates)
- `S` - 2-8 hours (small features, bug fixes)
- `M` - 1-3 days (medium features, complex bugs)
- `L` - 3-7 days (large features, major refactors)
- `XL` - 1-2 weeks (major features, full redesigns)
- `XXL` - 2+ weeks (major projects, complete overhauls)

#### **Sprint Field** (Single Select)
- `Sprint 1 (Oct 2025)` - Current sprint
- `Sprint 2 (Nov 2025)` - Next sprint
- `Sprint 3 (Dec 2025)` - Future sprint
- `Backlog` - Not assigned to sprint
- `Ongoing` - Continuous maintenance tasks

### 2.2 Advanced Fields (Optional)

#### **Assignee Field** (Person)
- Assign team members to specific tasks
- Multiple assignees supported for collaborative work

#### **Labels Field** (Labels)
- Use GitHub issue labels for additional categorization
- Examples: `good first issue`, `help wanted`, `duplicate`, `question`

#### **Milestone Field** (Milestone)
- Link to GitHub milestones for release planning
- Examples: `v2.1 Release`, `Q4 2025 Goals`, `Performance Milestone`

---

## 📊 Step 3: Create Project Views

### 3.1 Board View (Default)
**Purpose**: Kanban-style board for workflow management

**Configuration**:
- **Group by**: Status
- **Sort by**: Priority (descending), then Created date
- **Filters**: None (show all items)
- **Fields to show**: Title, Assignee, Priority, Type, Effort

### 3.2 Table View
**Purpose**: Detailed list view for comprehensive task management

**Configuration**:
- **Group by**: None
- **Sort by**: Priority (descending), then Status
- **Filters**: None (show all items)
- **Fields to show**: All fields
- **Column widths**: Adjust for optimal viewing

### 3.3 Priority View
**Purpose**: Focus on high-priority items

**Configuration**:
- **Group by**: Priority
- **Sort by**: Created date (newest first)
- **Filters**: Priority = Critical, High, Medium
- **Fields to show**: Title, Status, Type, Component, Assignee

### 3.4 Sprint Planning View
**Purpose**: Sprint-focused planning and tracking

**Configuration**:
- **Group by**: Sprint
- **Sort by**: Priority, then Type
- **Filters**: Sprint ≠ Backlog
- **Fields to show**: Title, Status, Priority, Type, Effort, Assignee

### 3.5 Component View
**Purpose**: Organize work by website components

**Configuration**:
- **Group by**: Component
- **Sort by**: Priority, then Status
- **Filters**: Status ≠ Done, Cancelled
- **Fields to show**: Title, Status, Priority, Type, Effort

---

## 🔄 Step 4: Import Existing Issues

### 4.1 Current Issues to Import
Based on the existing issues in your repository:

#### **Issue #3: README URLs**
- **Type**: 📚 Documentation
- **Priority**: 🟢 Low
- **Component**: 📚 Documentation
- **Status**: 📋 Backlog
- **Effort**: XS
- **Description**: Update README file URLs to link to live website instead of markdown files

#### **Issue #5: Bottom Bar and Report Issue**
- **Type**: 🐛 Bug
- **Priority**: 🟠 High
- **Component**: 🎨 UI/UX
- **Status**: 🔄 Todo
- **Effort**: S
- **Description**: Bottom bar and report issue functionality not showing on all pages

#### **Issue #6: Terms Page 404**
- **Type**: 🐛 Bug
- **Priority**: 🔴 Critical
- **Component**: 🏢 Companies
- **Status**: 🔄 Todo
- **Effort**: S
- **Description**: RK Oxygen Gorakhpur terms page returning 404 error

#### **Issue #7: Refund Policy Page 404**
- **Type**: 🐛 Bug
- **Priority**: 🔴 Critical
- **Component**: 🏢 Companies
- **Status**: 🔄 Todo
- **Effort**: S
- **Description**: RK Oxygen Gorakhpur refund policy page returning 404 error

### 4.2 Additional Tasks from TODO.md

#### **Backlog Items**:
- **Add more test coverage** (Type: 🔧 Maintenance, Priority: 🟡 Medium)
- **Add changelog/release notes** (Type: 📚 Documentation, Priority: 🟢 Low)
- **Add onboarding notes** (Type: 📚 Documentation, Priority: 🟡 Medium)
- **Add company logos** (Type: 📝 Content, Priority: 🟡 Medium)
- **Add print-friendly calculator styles** (Type: ✨ Feature, Priority: 🟢 Low)
- **Add keyboard shortcuts for calculators** (Type: ✨ Feature, Priority: 🟢 Low)

#### **Future Enhancements**:
- **Multi-language support** (Type: ✨ Feature, Priority: 🟢 Low, Effort: XL)
- **Blog/news section** (Type: ✨ Feature, Priority: 🟡 Medium, Effort: L)
- **PWA enhancements** (Type: ✨ Feature, Priority: 🟡 Medium, Effort: M)
- **Map integration** (Type: ✨ Feature, Priority: 🟡 Medium, Effort: M)
- **A/B testing** (Type: 🏗️ Infrastructure, Priority: 🟢 Low, Effort: L)

---

## ⚙️ Step 5: Set Up Automation

### 5.1 Built-in Automation Rules

#### **Auto-move Issues**
Create automation rules for seamless workflow:

**Rule 1: New Issues to Backlog**
- **Trigger**: Item added to project
- **Condition**: Item is an issue
- **Action**: Set Status to "📋 Backlog"

**Rule 2: Pull Request to In Review**
- **Trigger**: Item added to project  
- **Condition**: Item is a pull request
- **Action**: Set Status to "👀 In Review"

**Rule 3: Closed Issues to Done**
- **Trigger**: Issue closed
- **Action**: Set Status to "✅ Done"

**Rule 4: Merged PRs to Done**
- **Trigger**: Pull request merged
- **Action**: Set Status to "✅ Done"

### 5.2 Advanced Automation (GitHub Actions)

Create `.github/workflows/project-automation.yml`:

```yaml
name: Project Automation
on:
  issues:
    types: [opened, closed, labeled]
  pull_request:
    types: [opened, closed, merged, labeled]

jobs:
  update_project:
    runs-on: ubuntu-latest
    steps:
      - name: Update Project Status
        uses: actions/github-script@v7
        with:
          script: |
            const { owner, repo } = context.repo;
            const projectNumber = 1; // Your project number
            
            // Auto-assign priority based on labels
            if (context.payload.label?.name === 'critical') {
              // Set priority to Critical
              console.log('Setting priority to Critical');
            }
            
            // Auto-assign component based on file changes
            if (context.payload.pull_request) {
              const files = await github.rest.pulls.listFiles({
                owner,
                repo,
                pull_number: context.payload.pull_request.number
              });
              
              // Logic to determine component based on changed files
              for (const file of files.data) {
                if (file.filename.startsWith('companies/')) {
                  // Set component to Companies
                  console.log('Setting component to Companies');
                }
                if (file.filename.startsWith('Calc/')) {
                  // Set component to Calculators
                  console.log('Setting component to Calculators');
                }
              }
            }
```

---

## 📝 Step 6: Create Issue Templates

### 6.1 Bug Report Template
Create `.github/ISSUE_TEMPLATE/bug-report.yml`:

```yaml
name: 🐛 Bug Report
description: Report a bug or issue with the website
title: "[Bug]: "
labels: ["bug", "needs-triage"]
assignees: []

body:
  - type: markdown
    attributes:
      value: |
        Thanks for taking the time to report this bug! Please fill out the information below to help us resolve it quickly.

  - type: dropdown
    id: component
    attributes:
      label: Component
      description: Which part of the website is affected?
      options:
        - Homepage
        - Companies
        - Calculators
        - Visualizations
        - Navigation
        - Mobile/Responsive
        - Other
    validations:
      required: true

  - type: dropdown
    id: priority
    attributes:
      label: Priority
      description: How critical is this issue?
      options:
        - Critical (Site broken, security issue)
        - High (Important functionality broken)
        - Medium (Feature not working as expected)
        - Low (Minor issue, cosmetic)
    validations:
      required: true

  - type: textarea
    id: description
    attributes:
      label: Bug Description
      description: A clear description of what the bug is
      placeholder: "Describe the issue..."
    validations:
      required: true

  - type: textarea
    id: steps
    attributes:
      label: Steps to Reproduce
      description: Steps to reproduce the behavior
      placeholder: |
        1. Go to '...'
        2. Click on '....'
        3. Scroll down to '....'
        4. See error
    validations:
      required: true

  - type: textarea
    id: expected
    attributes:
      label: Expected Behavior
      description: What you expected to happen
    validations:
      required: true

  - type: textarea
    id: actual
    attributes:
      label: Actual Behavior
      description: What actually happened
    validations:
      required: true

  - type: textarea
    id: environment
    attributes:
      label: Environment
      description: Browser, device, and other relevant information
      placeholder: |
        - Browser: [e.g. Chrome 118, Safari 17]
        - Device: [e.g. iPhone 13, Desktop]
        - OS: [e.g. Windows 11, macOS 14]
        - Screen Size: [e.g. 1920x1080, Mobile]

  - type: textarea
    id: additional
    attributes:
      label: Additional Context
      description: Any other relevant information, screenshots, or logs
```

### 6.2 Feature Request Template
Create `.github/ISSUE_TEMPLATE/feature-request.yml`:

```yaml
name: ✨ Feature Request
description: Suggest a new feature or enhancement
title: "[Feature]: "
labels: ["enhancement", "needs-triage"]
assignees: []

body:
  - type: markdown
    attributes:
      value: |
        Thanks for suggesting a new feature! Please provide as much detail as possible.

  - type: dropdown
    id: component
    attributes:
      label: Component
      description: Which part of the website would this feature affect?
      options:
        - Homepage
        - Companies
        - Calculators
        - Visualizations
        - Navigation
        - Mobile/Responsive
        - Infrastructure
        - Documentation
        - Other
    validations:
      required: true

  - type: dropdown
    id: priority
    attributes:
      label: Priority
      description: How important is this feature?
      options:
        - High (Essential for users)
        - Medium (Would improve user experience)
        - Low (Nice to have)
    validations:
      required: true

  - type: textarea
    id: problem
    attributes:
      label: Problem Statement
      description: What problem does this feature solve?
      placeholder: "As a user, I want to... so that I can..."
    validations:
      required: true

  - type: textarea
    id: solution
    attributes:
      label: Proposed Solution
      description: How would you like this feature to work?
    validations:
      required: true

  - type: textarea
    id: alternatives
    attributes:
      label: Alternatives Considered
      description: Are there alternative approaches to solving this problem?

  - type: textarea
    id: additional
    attributes:
      label: Additional Context
      description: Any other relevant information, mockups, or examples
```

### 6.3 Content Update Template
Create `.github/ISSUE_TEMPLATE/content-update.yml`:

```yaml
name: 📝 Content Update
description: Request content updates or additions
title: "[Content]: "
labels: ["content", "needs-triage"]
assignees: []

body:
  - type: dropdown
    id: update_type
    attributes:
      label: Update Type
      description: What type of content update is needed?
      options:
        - New company addition
        - Company information update
        - Policy/legal document update
        - Calculator content update
        - General content correction
        - Translation/localization
    validations:
      required: true

  - type: dropdown
    id: urgency
    attributes:
      label: Urgency
      description: How urgent is this content update?
      options:
        - Critical (Legal/compliance requirement)
        - High (Important business information)
        - Medium (Standard update)
        - Low (Minor correction)
    validations:
      required: true

  - type: textarea
    id: current_content
    attributes:
      label: Current Content
      description: What is the current content that needs updating?
      placeholder: "Link to current page or describe current content..."

  - type: textarea
    id: requested_content
    attributes:
      label: Requested Changes
      description: What changes are needed?
      placeholder: "Describe the new or updated content..."
    validations:
      required: true

  - type: textarea
    id: business_justification
    attributes:
      label: Business Justification
      description: Why is this content update needed?

  - type: textarea
    id: additional
    attributes:
      label: Additional Information
      description: Any supporting documents, references, or context
```

---

## 📊 Step 7: Create Project Dashboard

### 7.1 Project Insights
Set up project insights to track:
- **Velocity** - Items completed per sprint
- **Burndown** - Progress toward sprint goals  
- **Flow** - Time items spend in each status
- **Distribution** - Work distribution by type, component, priority

### 7.2 Custom Charts
Create custom charts for:
- **Work by Component** - Pie chart showing work distribution
- **Priority Over Time** - Track priority item completion
- **Bug vs Feature Ratio** - Balance of maintenance vs new development
- **Team Workload** - Assignee workload distribution

---

## 📚 Step 8: Project Documentation

### 8.1 Project README
Create a project README accessible from the project board:

**Contents**:
- Project overview and goals
- Link to this setup guide
- Team roles and responsibilities  
- Sprint schedule and planning process
- Definition of done for different item types
- Escalation procedures for blocked items

### 8.2 Process Documentation
Document key processes:
- **Sprint Planning** - How sprints are planned and managed
- **Issue Triage** - How new issues are evaluated and prioritized
- **Code Review Process** - Pull request and review workflows
- **Release Process** - How releases are planned and deployed
- **Hotfix Process** - Emergency fix procedures

---

## 🎯 Step 9: Initial Project Population

### 9.1 Immediate Actions (This Week)
Create these high-priority items:

**Critical Bug Fixes**:
1. Fix RK Oxygen Gorakhpur terms page 404 (#6)
2. Fix RK Oxygen Gorakhpur refund policy page 404 (#7)
3. Implement bottom bar and report issue on all pages (#5)

**High Priority Tasks**:
1. Add comprehensive test coverage for calculators
2. Update README URLs to point to live site (#3)
3. Add onboarding documentation for contributors

### 9.2 Sprint 1 Goals (October 2025)
Focus areas for first sprint:
- **Bug Fixes** - Resolve all critical 404 errors
- **UI Consistency** - Ensure bottom bar appears on all pages
- **Documentation** - Update README and add contributor guides
- **Testing** - Improve test coverage for critical functionality

### 9.3 Backlog Organization
Organize backlog into themes:
- **Performance** - Speed optimization, Core Web Vitals
- **Accessibility** - WCAG compliance improvements
- **Content** - Company additions, policy updates
- **Features** - New calculators, visualization enhancements
- **Infrastructure** - Build improvements, automation

---

## 🚀 Step 10: Launch and Iteration

### 10.1 Team Onboarding
Schedule team onboarding sessions:
- Project board overview and navigation
- Field meanings and usage guidelines
- Workflow processes and automation
- Issue creation and triage procedures

### 10.2 Regular Reviews
Establish review cadences:
- **Daily Standups** - Quick status updates using project board
- **Weekly Sprint Reviews** - Progress assessment and blockers
- **Monthly Retrospectives** - Process improvements and optimization
- **Quarterly Planning** - Roadmap updates and priority reassessment

### 10.3 Continuous Improvement
Plan regular improvements:
- Monitor automation effectiveness
- Gather team feedback on processes
- Optimize views and fields based on usage
- Update templates based on common patterns

---

## 📋 Quick Start Checklist

- [ ] **Create GitHub Project** with appropriate name and description
- [ ] **Configure custom fields** (Status, Priority, Type, Component, Effort, Sprint)
- [ ] **Set up project views** (Board, Table, Priority, Sprint, Component)
- [ ] **Import existing issues** from repository
- [ ] **Create automation rules** for workflow management
- [ ] **Add issue templates** (Bug Report, Feature Request, Content Update)
- [ ] **Populate initial sprint** with high-priority items
- [ ] **Document processes** and team guidelines
- [ ] **Train team members** on project board usage
- [ ] **Schedule regular reviews** and iteration cycles

---

## 🔗 Resources and References

### GitHub Documentation
- [GitHub Projects Guide](https://docs.github.com/en/issues/planning-and-tracking-with-projects)
- [Project Automation](https://docs.github.com/en/issues/planning-and-tracking-with-projects/automating-your-project)
- [Issue Templates](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests)

### Best Practices
- [Agile Project Management](https://github.com/features/project-management/)
- [Kanban Board Setup](https://docs.github.com/en/issues/planning-and-tracking-with-projects/customizing-views-in-your-project)
- [Sprint Planning Guide](https://docs.github.com/en/issues/planning-and-tracking-with-projects/managing-iterations-in-your-project)

---

*GitHub Project Setup Guide Version: 1.0*  
*Last Updated: September 27, 2025*  
*Project Status: Ready for Implementation*