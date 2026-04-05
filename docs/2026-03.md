## 127people

- Added GitHub workflow and configuration files to support Copilot onboarding/setup, including a setup-step fix and a new instructions document for agents.
- Updated the Perl dependency list so the project’s `cpanfile` includes all required modules.
- Added Dependabot configuration under `.github` to support dependency update automation.
- Overall, March’s changes were small and focused on repository setup, dependency completeness, and developer tooling rather than product features.
---

## aphra-web

- Small month overall: the main project change was a build workflow update to display the Aphra version during site builds.
- The GitHub Actions workflow was also updated to use `actions/upload-artifact` v7.
- A minor documentation correction was made in the documentation index page.
---

## bs-checker

- Improved the checker’s handling of crawl failures and version parsing, including clearer reporting in the web output when HTTP errors or Bootstrap-related version lookups fail.
- Updated the site-fetching logic to use a more browser-like user agent and direct LWP requests, which fixed 403 errors and related workflow issues.
- Refined Bootstrap detection so it now distinguishes between “Bootstrap not used” and “Bootstrap version not found”, making error messages more accurate.
- Added and adjusted GitHub Actions/Copilot workflow configuration, including a new Copilot setup workflow and dependency bumps for checkout and upload-artifact.
- Made a few small clean-ups in the Perl code and documentation; overall, the month’s changes were fairly modest and focused on reliability and maintenance.
---

## claphamshopfronts

- Added a basic website under `docs/`, including a new `index.html` and `CNAME` file for site hosting.
- Created the initial empty database and accompanying DDL schema, establishing the project’s first data model.
- The month’s work was small and focused mainly on initial setup and deployment-related configuration rather than feature development or bug fixing.
---

## cool-stuff

- March was a small, content-focused month: the main change was a steady stream of new site entries added to `docs/_data/coolstuff.yml`.
- There was one manual update to the site data near the end of the month.
- The update workflow was adjusted slightly, with the fetch script moved into `bin/` and the GitHub Actions workflow updated to match.
---

## cpan/amazon-sites

- Added new author/metadata tests and a Copilot setup workflow, alongside repository onboarding guidance for contributors.
- Made a small round of Perl module clean-up in `Amazon::Site` and `Amazon::Sites`, including version handling and class/package declaration tweaks to satisfy tests.
- Fixed test-related issues in the module layout, with several follow-up edits to keep the xt checks passing.
- Prepared a release by updating the changelog and bumping the version; overall, the month’s changes were fairly small and focused on housekeeping and test compatibility.
---

## cpan/app-aphra

- Fixed a double-encoding bug and added a UTF-8 regression test, improving handling of encoded content.
- Added author-side tests and tidied metadata/dependency declarations, strengthening release checks.
- Made a series of Docker and build-script improvements, including a substantially reworked `docker/build` and a cleaner Dockerfile.
- Removed the auto-release workflow and added Copilot setup steps for the repository.
- Made a few small documentation and comment fixes, plus a release prep update for 0.2.9.
---

## cpan/app-blurfill

- Updated the Docker publishing workflow to newer major versions of the GitHub Actions used for build, login and buildx setup.
- Fixed a port number in the README, so the documented setup now matches the intended configuration.
- Changes were small overall, with no new features or broader refactoring visible in the log.
---

## cpan/app-httpthis

- Reworked the project away from Dist::Zilla towards a more conventional Perl distribution setup, adding a `Makefile.PL`, `INSTALL`, `LICENSE`, `MANIFEST`, and `README`, and removing the old Dist::Zilla configuration.
- Added and adjusted CI/workflow support, including a new debug workflow and a fix to the existing GitHub Actions trigger/setup.
- Made a small release-oriented update to `App::HTTPThis`, including a dependency fix and a tidy-up of POD ordering in the module documentation.
- Expanded author and compile checks, with new tests for distribution metadata, EOLs, tabs, POD syntax/coverage, and compile-time loading.
---

## cpan/app-linksite

- Added a new GitHub Actions workflow for static checks, introducing CI/deployment automation for the project.
- This appears to be a small, focused change for March, with no other code, documentation, or test updates shown in the log.
---

## cpan/genealogy-relationship

- Added support for two-parent relationships, with broader changes to ancestor, MRCA and coordinate calculations, plus new tests and test helpers to cover the updated behaviour.
- Introduced a configurable `parents_field_name` setting so the module can work with different parent field names, again backed by new tests.
- Refactored the code for compatibility with older Perl versions by switching to `Feature::Compat::Class` and adjusting the module and test classes accordingly.
- Made a few smaller maintenance updates: fixed the SYNOPSIS method name, updated the copyright year, cleaned up accidentally committed `wget-log` files, and added the missing release notes entries.
- Test coverage was improved, including clearer labels in the cousins test file.
---

## cpan/moox-role-seotags

- Updated the README and publishing setup so the project now presents more like a small website, with badges added and static publishing limited to changes in `README.md`.
- Fixed the Git links in `Makefile.PL` and removed the unnecessary Moose prerequisite.
- Addressed an experimental warnings issue in the module code.
- Overall, March’s work was fairly small and mostly focused on documentation, packaging, and release/deployment polish.
---

## cpan/plack-app-directoryindex

- Fixed the GitHub Actions workflow trigger and updated the workflow to use a newer `actions/checkout` version.
- Tightened the dependency requirement for `WebServer::DirIndex`, including a follow-up correction to the minimum version needed.
- Released version 0.2.1 and then 0.2.2, with the accompanying changelog and module metadata updates.
- Overall, March’s work was small and mostly maintenance-focused, with no major feature changes.
---

## cpan/toon

- Added support for tabular TOON syntax in the pure-Perl decoder/encoder, fixing round-trip behaviour for more complex data.
- Expanded the test suite with round-trip and more complex parsing coverage, including tabular data cases.
- Improved the `toon_pp` command-line tool with POD documentation, a `--version`/`-v` flag, and output that uses the script name rather than a hard-coded label.
- Updated the README to document the tabular syntax and clarify the supported syntax, and prepared the 0.1.0 release with accompanying metadata and changelog updates.
---

## cpan/webserver-dirindex

- Added and adjusted GitHub Pages/static-site workflow support, including a step to generate `index.html` and fixes to workflow triggers; the CI/deployment configuration was also updated to use newer GitHub Actions versions.
- Updated the README with badges and small wording fixes, alongside a badge correction.
- Made a series of versioning and packaging changes around the March releases, including bumping the module version and setting `$VERSION` in a more traditional way to keep `cpanm` happy.
- Added author-only tests for version and CPAN metadata checks.
- Made a couple of small maintenance fixes, including a typo correction and minor housekeeping in the CSS/module files.
---

## dave.org.uk

- The month was mostly routine automated updates: weekly data builds refreshed `docs/data/laststats.json` and the associated date file each week.
- There were also two small deployment workflow dependency bumps, updating `actions/configure-pages` and `actions/deploy-pages` in the GitHub Pages build workflow.
- No larger feature work, bug fixes, or refactoring is evident from the log; the changes look minor and maintenance-focused.
---

## davecross.co.uk

- Updated the books pages to use reusable include files for Amazon/store links, replacing the older inline link lists.
- Fixed a small content issue around the “Buy:” label on book pages, then later removed that label again as part of tidying the presentation.
- Added repository onboarding guidance for Copilot in `.github/copilot-instructions.md`.
- Overall, March’s changes were small and mostly focused on site content cleanup and a bit of configuration/documentation work.
---

## davorg.github.io

- Updated the README with a few small content tweaks, including adding more links and adjusting image sizing.
- The month’s work was very minor overall, with changes limited to documentation/content rather than code, tests or deployment.
---

## dmpweb

- Very small month of work overall, with a single minor change to the site’s `index.html`.
- One line was adjusted in the main page, suggesting a tiny content or wording correction rather than a broader feature or refactor.
---

## films

- Added a new `seen` property to watchlist entries and updated several entries accordingly, laying the groundwork for tracking films already watched.
- Introduced a UI change to display seen films in greyscale, with the effect clearing on hover.
- Made a small follow-up tweak to the watchlist data, including a typo fix and one additional film entry.
- Removed an unneeded ZIP artefact from the repository; overall, the month’s changes were fairly small and focused.
---

## fit

- The project was brought up to an initial working version, adding the main app, page layout, styling and plan data, along with a `.nojekyll` file for deployment on GitHub Pages.
- A substantial new feature was added for Google sign-in via Supabase, including user accounts and cloud progress storage, plus setup documentation and related UI/configuration changes.
- The login UI was then refined so the button hides correctly when signed in, and both auth buttons are hidden when authentication is not configured; the sign-in flow also had error-handling and event-listener fixes.
- There were a few small follow-up tweaks to configuration and a minor typo fix.
- The plan data was simplified by removing the roller.
---

## gigs

- Very small month overall: a single documentation tweak was made.
- Fixed a broken link in `index.md`.
---

## github_workflows

- Updated the GitHub Actions setup for CPAN testing, including ensuring a current toolchain, fixing a missing `shell` setting, and improving archive naming.
- Bumped `actions/upload-artifact` from v6 to v7 in the CPAN test workflows.
- These were small workflow/configuration changes rather than broader feature work.
---

## gitme

- Added a project website setup, including a new GitHub Pages-style workflow and Dependabot configuration.
- Updated the README with a GitHub badge, then fixed that badge shortly afterwards.
- Overall, March’s changes were small and focused on repository presentation and basic site/deployment configuration.
---

## got

- Added a new cast-status display so characters are shown as alive or dead.
- Updated the main cast data and adjusted the app logic to support the new status information.
- Refreshed the styling to accommodate the new presentation.
---

## learn.davecross.co.uk

- Very small month overall: the only project changes were a typo tidy-up in the slides template and a minor wording correction.
- Updated the GitHub Actions workflow to use `actions/upload-artifact` v7 instead of v6.
- No feature work, bug fixes, tests, or broader refactoring were evident in the log.
---

## perl5lib_auto

- Added initial website/deployment support by introducing a GitHub Pages-style workflow and Dependabot configuration.
- The month’s work appears to be small and focused, with no code changes beyond the new site/build automation files.
---

## perlschool-sales

- Added a substantial new Leanpub royalty-processing area, including a database schema, standing data, a SQLite database, and a large ingestion script for royalties.
- Introduced a monthly workflow document and expanded the README to explain how the Leanpub process works.
- Renamed and enhanced the royalties import script, adding `--dry-run`, `--verbose` and `--help` options to make it safer and easier to use.
- Added a new `allocate_royalties` helper script and updated the documentation to cover it.
- Set up project scaffolding for future automation, including a top-level `cpanfile` and a GitHub Copilot setup workflow.
---

## planetperl

- Updated the GitHub Actions build workflow to use `actions/upload-artifact` v7 instead of v6.
- This was a very small maintenance-only change, with no functional code changes, tests, or documentation updates.
---

## readme-to-index

- Updated the README with clearer guidance, including a note about installing Pandoc and links to the repository and issue tracker.
- Improved the action’s Pandoc installation mechanism in `action.yml`, suggesting a small but useful configuration refinement.
- Overall, March’s work was modest and focused mainly on documentation and setup clarity rather than new functionality.
---

## royalrels

- Added support for people with two parents, updating the relationship calculation so the generated family links are more accurate; this also corrected some previously wrong cousin relationships.
- Extended the monarch data back to Alfred the Great via two lineages, with large regenerations of the generated data files and CSV inputs.
- Improved the legend in the web view: it now uses a horizontal layout, smaller boxes, less padding, a hide/show toggle, and better behaviour on narrow screens.
- Added a Copilot setup workflow and refreshed the agent onboarding instructions to match the current project structure and dependency setup.
---

## step-story

- Built out the StepStory static web app from scratch, adding the main app logic, interface and styling for the MVP.
- Added progress-report features including an estimated arrival date, and made “kilometres walked so far” optional by calculating it from daily distance and elapsed days when omitted.
- Made a small wording tweak to the feedback text for clarity.
- Added GitHub Pages deployment via GitHub Actions, so the site now deploys automatically from the main branch.
- Added repository configuration for Copilot onboarding and Dependabot updates.
---

## succession

- The month was dominated by automated database refreshes from the audit workflow, with repeated updates to `data/succession_dump.sql` and the bundled SQLite database; these appear to be routine data synchronisations rather than feature work.
- There was a small build/configuration change to the GitHub Actions workflows, bumping `actions/upload-artifact` from v6 to v7 in both the audit and container build pipelines.
- No substantive application code changes, bug fixes, or documentation updates are evident in the log for March.
---

## tiobe-perl

- Added an automated TIOBE data updater script and GitHub Actions workflow, introducing scheduled data refreshes for the project.
- Adjusted the update schedule to run at 03:00 UTC.
- Added a `.gitignore` and cleaned up an accidentally committed `__pycache__` file.
- Updated the March 2026 TIOBE data file in the documentation data set; overall, the month’s changes were fairly small.
---

