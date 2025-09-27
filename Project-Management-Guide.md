# RK Groups Project Management Guide

Welcome to the RK Groups website project management system! This guide will help you understand how to use our GitHub Project board, contribute effectively, and follow our development workflows.

---

## 🎯 Project Overview

Our GitHub Project board serves as the central hub for managing all aspects of the RK Groups website development, including:

- **Feature Development** - New calculators, visualizations, and functionality
- **Bug Fixes** - Resolving issues and improving stability
- **Content Management** - Adding companies, updating policies, maintaining accuracy
- **Performance & Quality** - SEO, accessibility, and speed optimizations
- **Documentation** - Keeping guides and processes up-to-date

**Project URL**: `https://github.com/rk-Groups/rk-Groups.github.io/projects/1`

---

## 📋 Understanding Project Fields

### Status Field
Our workflow follows these status stages:

- **📋 Backlog** - Items identified but not yet prioritized
- **🔄 Todo** - Prioritized items ready to be worked on
- **🚧 In Progress** - Currently being developed
- **👀 In Review** - Under code review or testing
- **✅ Done** - Completed and deployed
- **🚫 Cancelled** - Items no longer needed

### Priority Levels
- **🔴 Critical** - Security issues, site outages, legal compliance
- **🟠 High** - Important features, significant bugs affecting users
- **🟡 Medium** - Standard development tasks, improvements
- **🟢 Low** - Nice-to-have features, minor enhancements
- **⚪ Planning** - Research and discovery work

### Work Types
- **🐛 Bug** - Fixing broken functionality
- **✨ Feature** - Adding new capabilities
- **📝 Content** - Website content and company information
- **🔧 Maintenance** - Updates, refactoring, technical debt
- **📚 Documentation** - Guides, processes, and help content
- **🏗️ Infrastructure** - Build system, deployment, tooling
- **🎨 Design** - UI/UX improvements and visual updates

### Components
- **🏠 Homepage** - Main landing page and site entry
- **🏢 Companies** - Company pages and business profiles
- **🧮 Calculators** - Interactive calculation tools
- **📊 Visualizations** - 3D neural networks, charts, dashboards
- **🎨 UI/UX** - Design system and user interface
- **🔧 Build System** - Jekyll, testing, and deployment
- **📱 Mobile** - Responsive design and mobile optimization
- **♿ Accessibility** - WCAG compliance and inclusive design
- **🔍 SEO** - Search optimization and performance

---

## 🚀 Getting Started

### 1. Accessing the Project Board
1. Navigate to the repository: `https://github.com/rk-Groups/rk-Groups.github.io`
2. Click on the **"Projects"** tab
3. Select **"RK Groups Website Development"**

### 2. Understanding Project Views

#### **Board View** (Default Kanban)
- **Best for**: Daily workflow management
- **Shows**: Items organized by status columns
- **Use when**: Planning daily work, tracking progress

#### **Table View** (Detailed List)
- **Best for**: Comprehensive task management
- **Shows**: All fields in spreadsheet format
- **Use when**: Bulk editing, detailed planning, reporting

#### **Priority View** (High-Priority Focus)
- **Best for**: Focusing on urgent work
- **Shows**: Items filtered and grouped by priority
- **Use when**: Sprint planning, emergency response

#### **Sprint Planning View**
- **Best for**: Organizing work into time-boxed iterations
- **Shows**: Items grouped by sprint assignments
- **Use when**: Planning releases, team coordination

#### **Component View**
- **Best for**: Understanding work distribution across site areas
- **Shows**: Items organized by website component
- **Use when**: Architecture planning, team specialization

---

## 📝 Creating Issues and Tasks

### Using Issue Templates

#### 🐛 Bug Report
Use for reporting broken functionality:
1. Choose **"Bug Report"** template
2. Select affected **Component** and **Priority**
3. Provide clear **reproduction steps**
4. Include **environment details** (browser, device, etc.)

#### ✨ Feature Request
Use for suggesting new functionality:
1. Choose **"Feature Request"** template
2. Describe the **problem** being solved
3. Outline your **proposed solution**
4. Consider **alternative approaches**

#### 📝 Content Update
Use for website content changes:
1. Choose **"Content Update"** template
2. Specify **update type** (company info, policies, etc.)
3. Describe **current content** and **requested changes**
4. Provide **business justification**

#### 🔧 Maintenance
Use for technical improvements:
1. Choose **"Maintenance"** template
2. Select **maintenance type** (dependencies, performance, etc.)
3. Describe **current situation** and **proposed solution**
4. Assess **impact** of not addressing the issue

### Manual Task Creation
For quick tasks, you can create items directly in the project board:

1. Click **"+ Add item"** in any status column
2. Enter a descriptive title
3. Set appropriate **Type**, **Priority**, and **Component**
4. Assign to team members if known
5. Add detailed description in the item

---

## 🔄 Development Workflow

### 1. Planning Phase
- **Weekly Sprint Planning** - Team reviews backlog and assigns work
- **Priority Assessment** - Ensure critical items are addressed first
- **Capacity Planning** - Balance team workload and expertise
- **Dependency Management** - Identify and plan for task dependencies

### 2. Development Phase
- **Move to In Progress** - When you start working on an item
- **Regular Updates** - Update progress and add comments
- **Draft Pull Requests** - Create draft PRs for work-in-progress
- **Collaboration** - Tag team members for input or reviews

### 3. Review Phase
- **Code Review** - All changes require team member review
- **Testing Verification** - Ensure functionality works as expected
- **Accessibility Check** - Verify WCAG compliance for UI changes
- **Performance Validation** - Test impact on site speed and usability

### 4. Deployment Phase
- **Merge Approval** - Final approval from project maintainers
- **Automated Deployment** - GitHub Pages automatically builds and deploys
- **Post-Deployment Testing** - Verify changes work on live site
- **Item Closure** - Move items to "Done" status

---

## 🤖 Automated Workflows

Our project uses automation to streamline management:

### Automatic Status Updates
- **New Issues** → Automatically move to "📋 Backlog"
- **New Pull Requests** → Automatically move to "👀 In Review"
- **Merged PRs** → Automatically move to "✅ Done"
- **Closed Issues** → Move to "✅ Done" or "🚫 Cancelled"

### Smart Field Assignment
- **Bug Labels** → Set Type to "🐛 Bug" and Priority to "🟠 High"
- **Feature Labels** → Set Type to "✨ Feature"
- **File Changes** → Auto-assign Component based on modified files
- **Critical Labels** → Set Priority to "🔴 Critical"

### Notification Management
- **Team Mentions** → Notify relevant team members
- **Status Changes** → Update assignees on progress
- **Review Requests** → Alert reviewers when ready

---

## 👥 Team Collaboration

### Roles and Responsibilities

#### **Project Owner**
- **Responsibilities**: Strategic direction, priority setting, stakeholder communication
- **Permissions**: Full project access, milestone planning, release decisions

#### **Lead Developers**
- **Responsibilities**: Technical architecture, code review, mentoring
- **Permissions**: Repository administration, workflow configuration, team coordination

#### **Developers**
- **Responsibilities**: Feature development, bug fixes, testing
- **Permissions**: Issue creation, pull request submission, peer review

#### **Content Managers**
- **Responsibilities**: Business information, policy updates, company additions
- **Permissions**: Content issue creation, content review and approval

### Communication Guidelines

#### **Issue Comments**
- **Be specific** - Provide clear, actionable feedback
- **Be constructive** - Focus on solutions, not problems
- **Be timely** - Respond to mentions and requests promptly
- **Use @mentions** - Tag relevant team members for visibility

#### **Pull Request Reviews**
- **Review promptly** - Aim for same-day review for non-draft PRs
- **Test changes** - Don't just read code, test functionality
- **Ask questions** - If something isn't clear, ask for clarification
- **Approve explicitly** - Use GitHub's review approval system

#### **Status Updates**
- **Daily progress** - Update item status as work progresses
- **Blockers** - Immediately flag any obstacles or dependencies
- **Completion** - Move items to appropriate status when finished
- **Documentation** - Add comments explaining complex decisions

---

## 📊 Tracking and Reporting

### Project Metrics

#### **Velocity Tracking**
- Monitor items completed per sprint
- Identify team capacity and planning accuracy
- Adjust future sprint sizing based on historical data

#### **Quality Metrics**
- **Bug Detection Rate** - New bugs found vs fixed
- **Review Efficiency** - Time from PR creation to merge
- **Rework Rate** - Items that need significant changes after review

#### **Component Health**
- **Technical Debt** - Outstanding maintenance items per component
- **Feature Coverage** - New features vs bug fixes ratio
- **Performance Impact** - Site speed and accessibility scores

### Regular Reviews

#### **Daily Standups** (Optional)
- **What did you complete yesterday?**
- **What will you work on today?**
- **Are there any blockers or dependencies?**
- **Do you need help or have questions?**

#### **Weekly Sprint Reviews**
- **Completed work review** - Demonstrate finished features
- **Blockers discussion** - Address ongoing obstacles
- **Next week planning** - Adjust priorities and assignments
- **Process improvements** - Discuss workflow enhancements

#### **Monthly Retrospectives**
- **What went well?** - Celebrate successes and effective practices
- **What could be improved?** - Identify process pain points
- **Action items** - Specific improvements to implement
- **Tool effectiveness** - Evaluate project management tools and processes

---

## 🔧 Advanced Project Features

### Custom Filters and Searches

#### **Find High-Priority Open Work**
```
is:open priority:"🔴 Critical" OR priority:"🟠 High"
```

#### **Filter by Your Assignments**
```
assignee:@me is:open
```

#### **Find Specific Component Work**
```
component:"🧮 Calculators" status:"🔄 Todo"
```

#### **Recent Activity**
```
updated:>2025-09-20 status:"🚧 In Progress"
```

### Keyboard Shortcuts
- **`c`** - Create new item
- **`/`** - Focus search box
- **`g` + `i`** - Go to Issues
- **`g` + `p`** - Go to Pull Requests
- **`?`** - Show all keyboard shortcuts

### Integration Features

#### **Milestone Tracking**
- Link items to release milestones
- Track progress toward major goals
- Plan feature releases and deadlines

#### **Label Management**
- Use consistent labeling for categorization
- Filter and search by labels
- Automate workflows based on labels

#### **External Tools**
- **Slack Integration** - Notifications in team channels
- **Calendar Integration** - Sync sprint schedules
- **Analytics Tools** - Export data for reporting

---

## 📚 Resources and References

### Quick Reference Links
- **Project Board**: https://github.com/rk-Groups/rk-Groups.github.io/projects/1
- **Repository**: https://github.com/rk-Groups/rk-Groups.github.io
- **Live Site**: https://rk-groups.github.io
- **Documentation**: Available in repository `/dev/` folder

### GitHub Documentation
- [GitHub Projects Guide](https://docs.github.com/en/issues/planning-and-tracking-with-projects)
- [Project Views](https://docs.github.com/en/issues/planning-and-tracking-with-projects/customizing-views-in-your-project)
- [Project Automation](https://docs.github.com/en/issues/planning-and-tracking-with-projects/automating-your-project)

### Development Resources
- **Jekyll Documentation**: https://jekyllrb.com/docs/
- **Material UI Guidelines**: Refer to `/assets/css/mui.css`
- **Testing Guide**: See `/scripts/test-before-push.ps1`
- **Deployment Process**: Automated via GitHub Pages

---

## 🆘 Getting Help

### Common Questions

**Q: How do I report a bug?**
A: Use the "🐛 Bug Report" issue template with detailed reproduction steps and environment information.

**Q: How do I request a new feature?**
A: Use the "✨ Feature Request" template with clear problem description and proposed solution.

**Q: How do I update company information?**
A: Use the "📝 Content Update" template specifying the company and required changes.

**Q: My item is blocked. What should I do?**
A: Add a comment explaining the blocker and mention relevant team members using @username.

**Q: How do I know what to work on next?**
A: Check the "Priority View" for high-priority items in "🔄 Todo" status within your expertise area.

### Getting Support

#### **Technical Issues**
- **Search existing issues** first to avoid duplicates
- **Use appropriate templates** for consistent information
- **Provide detailed context** including error messages and environment
- **Tag relevant team members** who might have expertise

#### **Process Questions**
- **Check this guide** for standard procedures
- **Ask in issue comments** for public discussion
- **Mention project maintainers** for policy clarifications
- **Suggest improvements** for workflow enhancements

#### **Urgent Issues**
- **Use "🔴 Critical" priority** for genuine emergencies
- **Create detailed issue** even for urgent items
- **Mention all relevant team members** for immediate attention
- **Follow up quickly** with additional context if needed

---

## 🎯 Success Metrics

### Project Health Indicators

#### **Green (Healthy)**
- ✅ Critical items resolved within 24 hours
- ✅ High-priority items completed within sprint
- ✅ Less than 20% of work carried over between sprints
- ✅ All PRs reviewed within 2 business days
- ✅ No items stuck in "In Progress" for > 1 week

#### **Yellow (Attention Needed)**
- ⚠️ Critical items taking > 48 hours to resolve
- ⚠️ 20-40% of work carried over between sprints
- ⚠️ PRs taking > 3 business days for review
- ⚠️ Items stuck in "In Progress" for > 1 week
- ⚠️ Increasing backlog size without corresponding completion

#### **Red (Action Required)**
- 🔴 Critical items unresolved for > 72 hours
- 🔴 > 40% of work carried over between sprints
- 🔴 PRs sitting without review for > 5 business days
- 🔴 Multiple items stuck in "In Progress" for > 2 weeks
- 🔴 Backlog growing faster than completion rate

### Continuous Improvement

#### **Monthly Assessment**
Review project health indicators and adjust processes as needed:
- **Team capacity** - Are we taking on too much work?
- **Process efficiency** - Are there workflow bottlenecks?
- **Communication effectiveness** - Are team members staying informed?
- **Tool usage** - Is the project board meeting our needs?

#### **Quarterly Planning**
- **Roadmap review** - Align project goals with business objectives
- **Team growth** - Plan for new team members and skill development
- **Tool evaluation** - Consider new tools or workflow improvements
- **Process documentation** - Update guides based on lessons learned

---

*Project Management Guide Version: 1.0*  
*Last Updated: September 27, 2025*  
*Project Status: Ready for Team Adoption*