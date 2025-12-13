---
name: web-browser
description: Web browsing and interaction skills. Use when you need to search, navigate, or interact with web content. Auto-activates for: "search the web", "open URL", "check website", "analyze page".
---

# Web Browser Skill

## Core Principle

**Navigate efficiently**: Find information with minimal clicks and focused searches.

## When to Use This Skill

This skill auto-activates when users request:
- "Search the web for..."
- "Open [URL]"
- "Check the status of..."
- "Analyze this webpage"
- "Find documentation for..."
- "What does X mean?"
- "Compare these services"

## Web Browsing Workflow

### 1. Define Information Need

- What specific information are you seeking?
- What question needs answering?
- What format is needed (quick answer, detailed analysis)?

### 2. Search Strategy

**Use specific, focused queries**:
- ✅ `"error 500 Nginx proxy_pass configuration"`
- ❌ `"website not working"`

**Advanced search techniques**:
- Site-specific: `site:example.com "error message"`
- Filetype: `filetype:pdf configuration guide`
- Exact phrase: `"exact error message"`
- Exclude terms: `error message -forum`

### 3. Page Navigation

**Effective page reading**:
- Scan headings and subheadings
- Look for tables of contents
- Check documentation sections
- Use in-page search (Ctrl+F)
- Focus on recent information

### 4. Information Extraction

**Key techniques**:
- Identify main points in first paragraph
- Look for code examples for technical queries
- Check documentation version
- Verify source credibility
- Cross-reference with multiple sources

### 5. Verification

**Before acting on information**:
- Check source reputation
- Verify date (is this still relevant?)
- Look for community validation
- Cross-check with official documentation
- Check for updates

## Common Web Tasks

### Researching Error Messages

1. Search for exact error message in quotes
2. Look for recent solutions (less than 2 years)
3. Check official documentation first
4. Look for solutions from trusted sources
5. Verify solution matches your environment

### Comparing Services

1. Identify key features to compare
2. Create comparison matrix
3. Check pricing structure
4. Look for third-party reviews
5. Check recent experiences

### Documentation Navigation

```bash
# Typical documentation structure
- Introduction
- Installation
- Configuration
- Features
- Examples
- FAQ
- API Reference
```

**Navigation tips**:
- Look for version-specific documentation
- Check examples first for quick understanding
- Use search within documentation
- Look for migration guides when upgrading

## Browser Developer Tools

### Essential Tools

**Elements/Inspector**:
- Inspect HTML structure
- Debug CSS in real-time
- View computed styles
- Edit DOM for testing

**Console**:
- Run JavaScript commands
- View errors/warnings
- Debug scripts
- Test API calls

**Network**:
- Monitor HTTP requests
- Analyze load times
- Check headers/cookies
- Debug API responses

**Sources**:
- Browse source files
- Set breakpoints
- Debug step-by-step
- Watch variables

### Common Developer Tasks

**Check API endpoint**:
```javascript
// In console
fetch('/api/data')
  .then(r => r.json())
  .then(console.log)
```

**Test page performance**:
```javascript
// Measure render time
performance.mark('start');
// ... page actions
performance.mark('end');
performance.measure('render', 'start', 'end');
```

## Quick Reference Commands

```bash
# Open URL in browser
open https://example.com

# Search with specific parameters
search "error message" site:stackoverflow.com

# Download page for offline reading
wget -O page.html https://example.com

# Check page structure
curl -s https://example.com | grep -A 10 "<div class="content""

# Check response headers
curl -I https://example.com
```

## Page Analysis Techniques

### Identify Page Structure

**Key indicators**:
- Check `<title>` for page purpose
- Look for meta description
- Identify main content areas
- Find navigation menus
- Locate footer information

**CSS selectors for analysis**:
```css
/* Main content areas */
main, article, .content, #main

/* Navigation */
nav, .nav, .menu

/* Headers/Footers */
header, footer, .header, .footer
```

### Content Extraction

**Using browser console**:
```javascript
// Extract all links
const links = Array.from(document.querySelectorAll('a'))
  .map(a => ({text: a.textContent, href: a.href}))

// Extract main text content
const mainText = document.querySelector('main')?.innerText

// Get page metadata
const meta = {
  title: document.title,
  description: document.querySelector('meta[name="description"]')?.content,
  keywords: document.querySelector('meta[name="keywords"]')?.content
}
```

## Paywall and Access Workarounds

### Alternative Access Methods

**Textise dot iitty**:
- Convert pages to plain text
- Remove paywall restrictions
- Simplify article reading

**Reader Mode**:
- Most browsers have built-in reader modes
- Removes ads and extraneous content
- Focuses on main article text

**Archive.org**:
- Check Wayback Machine snapshots
- Access historical versions
- Bypass some restrictions

## Common Pitfalls

- **Information overload**: Focus on one question at a time
- **Outdated information**: Check dates on documentation
- **Source bias**: Look at multiple sources
- **Confirmation bias**: Seek disconfirming evidence
- **Incomplete understanding**: Read the full context
- **Ignoring version differences**: Always check version

## Web Navigation Checklist

Before finalizing web research:
- [ ] Searched with exact error message
- [ ] Checked multiple sources
- [ ] Verified documentation version
- [ ] Found examples matching your environment
- [ ] Confirmed information is current
- [ ] Cross-referenced with official documentation

## Remember

- Web searches work best with specific, technical queries
- Official documentation > random blog posts
- Version compatibility matters
- Time is a critical factor (is this still relevant?)
- The most recent answer isn't always the right answer
- Always verify before implementation
- Context matters more than isolated code snippets