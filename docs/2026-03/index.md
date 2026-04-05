## 127people

- Added GitHub configuration to support automation, including Dependabot settings and a Copilot setup workflow.
- Expanded the project’s Copilot onboarding guidance with a new instructions file for agent use.
- Fixed dependency and setup issues so the project’s Perl dependencies are declared more completely and the Copilot setup runs from the correct working directory.
- Overall, March’s changes were small and focused on repository configuration and build/setup reliability rather than product features.

---

## aphra-web

- Updated the site build workflow to display the Aphra version during builds, and also bumped the `actions/upload-artifact` GitHub Action from v6 to v7.
- Made a small documentation correction in `in/documentation/index.html.md`.
- Overall, March’s changes were minor and focused on build/deployment configuration plus a small docs fix.

---

## bs-checker

- Added clearer crawl error handling and reporting, including surfacing HTTP failures and stylesheet version-parse problems in the documentation/UI.
- Improved how the checker fetches pages, switching to a more reliable LWP-based approach with browser-like headers and a custom user agent to avoid 403 errors.
- Refined Bootstrap detection so it now distinguishes between “Bootstrap not used” and “Bootstrap version not found”, making site checks more accurate.
- Made a small amount of refactoring and cleanup in `lib/BS_Checker.pm`, including simplifying some variable handling and removing redundant initialisation.
- Updated GitHub Actions workflow configuration and repository onboarding files for Copilot, plus a couple of dependency bumps; overall these changes were fairly small and focused on maintenance.

---

## claphamshopfronts

- Added a basic website for the project, including a new `docs/index.html` page.
- Introduced the initial empty database and schema definition for the application.
- Made a small deployment/configuration change around the site’s `CNAME` file, with a brief add/remove/add sequence.

---

## cool-stuff

- March was a small, content-focused month: the main change was a steady stream of new site entries added to `docs/_data/coolstuff.yml`.
- There was one manual update to the same data file, suggesting a minor curation or correction alongside the automated additions.
- The update workflow was adjusted slightly, with the site-fetching script moved into `bin/` and the GitHub Actions workflow updated to match.

---

## cpan/amazon-sites

- Added new author-side tests for version metadata and CPAN META checks, though they were noted as currently failing at the time.
- Made a series of small fixes to `Amazon::Site` and `Amazon::Sites` to satisfy the new tests, including adjusting package/version declarations and tidying class syntax.
- Bumped the distribution version in preparation for release and updated the changelog.
- Added Copilot-related repository setup and onboarding files, including a workflow and instructions document.

---

## cpan/app-aphra

- Fixed a double-encoding bug and added a UTF-8 regression test, improving handling of encoded content.
- Added author-side tests and tidied up metadata/dependency declarations, strengthening release checks and packaging.
- Made a series of Docker and build-script improvements, including a substantially reworked `docker/build` and a better `Dockerfile`.
- Removed the auto-release workflow and added Copilot setup steps for GitHub Actions.
- A few small documentation and comment fixes were also made, alongside prep work for release 0.2.9.

---

## cpan/app-blurfill

- Updated the Docker publishing workflow to newer major versions of the GitHub Actions used for build, login and buildx, which is a small maintenance/configuration refresh.
- Fixed the README’s port number so the documented setup matches the current configuration.
- No other functional changes, bug fixes or feature work are shown in the March log.

---

## cpan/app-httpthis

- The project was moved away from Dist::Zilla towards a more traditional Perl distribution setup, with a new `Makefile.PL`, updated packaging files, and refreshed documentation such as `INSTALL`, `LICENSE`, `README` and `MANIFEST`.
- `App::HTTPThis` saw some small code clean-ups, including a fix to Pod ordering and a dependency-related version update.
- Test coverage and author checks were expanded, with new compile and metadata-style tests added alongside updates to existing EOL, tab and Pod-related checks.
- GitHub Actions workflows were adjusted, including a debug workflow and some tweaks to existing CI/setup configuration.
- Overall, March’s changes were fairly substantial in setup and packaging, but the application code changes themselves were relatively small.

---

## cpan/app-linksite

- Added a new GitHub Actions workflow for static checks, introducing CI/deployment automation for the repository.
- The month’s change set was very small and focused entirely on build/configuration work; no application code, tests, or documentation were changed.

---

## cpan/genealogy-relationship

- Added support for people with two parents, including updates to ancestor, MRCA and coordinate-related logic, plus new tests and test helpers to cover the new behaviour.
- Introduced a configurable `parents_field_name` setting so the module can work with different parent field names, again backed by new tests.
- Refactored the code for compatibility with older Perl versions by switching to `Feature::Compat::Class`.
- Made a small release housekeeping pass: updated the changelog and version to 2.0.0, fixed a SYNOPSIS method name, refreshed the copyright year, and removed accidentally committed `wget-log` files.

---

## cpan/moox-role-seotags

- Updated the README and site publishing setup, including adding badges and turning the README into a simple website for the project.
- Adjusted the GitHub Actions workflow so the site is only republished when `README.md` changes, reducing unnecessary deployment runs.
- Fixed the Git links in `Makefile.PL` and removed an unnecessary Moose prerequisite.
- Made a small code fix to address experimental warnings in the module.

---

## cpan/plack-app-directoryindex

- Fixed the GitHub Actions workflow trigger and updated the checkout action used by the copilot setup workflow.
- Released version 0.2.1 and then 0.2.2, with the latter correcting the required version of `WebServer::DirIndex`.
- Tightened the module and build metadata so the distribution now requires `WebServer::DirIndex` 0.1.4.
- Overall, March’s changes were small and mostly focused on dependency/version housekeeping and CI configuration.

---

## cpan/toon

- Added support for tabular TOON syntax in the pure-Perl decoder/encoder, fixing round-trip behaviour and extending the parser to handle more complex data structures.
- Expanded test coverage for the new tabular format and other complex parsing cases.
- Improved the `toon_pp` command-line tool with POD documentation, a `--version`/`-v` flag, and a small cleanup to derive its name from the executable rather than a hard-coded string.
- Updated the README to document the tabular syntax and broaden the description of supported syntax, and prepared the 0.1.0 release with accompanying changes to versioning and release notes.

---

## cpan/webserver-dirindex

- Added and adjusted GitHub Pages/static site workflow support, including a step to generate `index.html`, trigger fixes, and dependency updates for the Actions used by the deployment workflow.
- Updated the README with badges and other small documentation tweaks.
- Made a series of versioning and packaging changes around early March releases, including setting `$VERSION` in the traditional way and adding a package line to keep `cpanm` happy.
- Added author-side tests for version and CPAN metadata checks.
- Made a few small follow-up fixes, including a typo correction and minor CSS/documentation updates.

---

## dave.org.uk

- The month was dominated by routine weekly data refreshes, with `docs/data/laststats.json` and `docs/data/date.dat` updated four times as part of the automated weekly data build.
- There were also two small deployment workflow dependency bumps, upgrading `actions/configure-pages` and `actions/deploy-pages` in the GitHub Pages build workflow.
- No broader feature work, bug fixes, or documentation changes are evident in the March log.

---

## davecross.co.uk

- Updated the books page to use new `amazon-store` and `buy_book` includes, replacing the older Amazon link lists and fixing a brief loss of the “Buy:” text.
- Added repository onboarding guidance in `.github/copilot-instructions.md`.
- Made a small follow-up tweak to the book-buying include after the new layout was introduced.
- Overall, March’s changes were modest and focused on improving the books section and related site configuration.

---

## davorg.github.io

- Updated the README with a few small content tweaks, mainly around image sizing and presentation.
- Added a handful of extra links to the README.
- Overall, March’s changes were minor and documentation-only, with no code, build, test or deployment work evident.

---

## dmpweb

- Very small month of work: a single minor change to `index.html`.
- One line was adjusted in the page content, with no broader feature, build, test, or deployment changes visible in the log.

---

## films

- Added support for marking watchlist entries as seen, with several entries updated in the watchlist data.
- Updated the site to display seen films in greyscale, with the effect clearing on hover.
- Made a small supporting change to the update script and stylesheet for that visual treatment.
- Tidied the watchlist data further with a typo fix and one new film entry; overall, March’s changes were fairly small.
- Removed an unneeded ZIP file from the repository.

---

## fit

- Added the initial version of the app, with the main interface, styling and plan data, plus a `.nojekyll` file for GitHub Pages deployment.
- Introduced Google sign-in via Supabase for user accounts and cloud progress storage, with accompanying setup documentation and UI/configuration changes.
- Fixed a few early issues around authentication, including the login button staying visible when signed in, button re-enabling on error, and hiding auth controls when unconfigured.
- Made small follow-up tweaks to configuration and removed the roller from the plan data.

---

## gigs

- A very small change: fixed a broken link in `index.md`.
- No other March work is shown in the log, so this month appears to have been limited to a minor documentation correction.

---

## github_workflows

- Updated the GitHub Actions setup for CPAN testing, including ensuring a current toolchain, adding a missing `shell` setting, and improving archive naming.
- Bumped `actions/upload-artifact` from v6 to v7 in the workflow files.
- Overall, March’s changes were small and focused on CI/workflow maintenance rather than application code.

---

## gitme

- Added a project website setup, including a new GitHub Pages-style workflow and Dependabot configuration.
- Updated the README with a GitHub badge, then fixed that badge shortly afterwards.
- Overall, March’s changes were small and mostly focused on repository presentation and basic site/deployment configuration.

---

## got

- Added a new cast-status display so characters are shown as alive or dead.
- Updated the main cast data to support that status information.
- Adjusted the app logic and styling to present the new status cleanly in the interface.

---

## learn.davecross.co.uk

- Very small month overall: just a minor typo fix in the slides template.
- Updated the site build workflow to use a newer version of `actions/upload-artifact`.
- No new features, tests, or broader refactoring were evident from the log.

---

## perl5lib_auto

- Added basic website/deployment support by introducing a new GitHub Pages-style workflow and Dependabot configuration.
- The change is small and focused on project infrastructure rather than application code.

---

## perlschool-sales

- Added a substantial new Leanpub royalty-processing area, including a database schema, standing data, a SQLite database, and a large set of Perl schema/result classes.
- Introduced and then refined the royalty import workflow, renaming the script to `import_royalties` and adding `--dry-run`, `--verbose` and `--help` options.
- Added a new `allocate_royalties` script to handle royalty allocation, alongside updates to the monthly processing documentation.
- Expanded the top-level project documentation and onboarding material, including the README, monthly workflow notes, and Copilot setup instructions.
- Added a top-level `cpanfile` and a GitHub Actions workflow for Copilot setup; overall, this was a fairly large month of new functionality and supporting configuration.

---

## planetperl

- Updated the site build workflow to use `actions/upload-artifact` v7 instead of v6.
- This was a very small maintenance change, with no other functional code, documentation, or test updates in the month.

---

## readme-to-index

- Improved the README with clearer guidance, including a note about installing Pandoc and links to the repository and issue tracker.
- Updated the GitHub Action configuration to use a better mechanism for installing Pandoc.
- Made a small wording tweak to an existing note in the documentation.
- Overall, March’s work was modest and focused on documentation and setup improvements rather than new product features.

---

## royalrels

- Added support for recording two parents per monarch, which improved relationship calculations and corrected some previously wrong results, including James V of Scotland and Elizabeth I.
- Extended the monarch data back to Alfred the Great via two lineages, with further adjustment to prefer the Wessex route from Alfred to Matilda.
- Made several small front-end legend improvements in the documentation view: smaller boxes, less padding, a hide/show toggle, and better behaviour on narrow screens.
- Updated project setup and contributor guidance for the new architecture, including Copilot onboarding, dependency instructions, and a new setup workflow.

---

## step-story

- The project moved from a minimal initial commit to a working static web app for StepStory Ultra MVP, with the main UI, styling and client-side logic added in one substantial change.
- Core progress-report behaviour was expanded: estimated arrival dates are now shown, and “kilometres walked so far” can be left blank and calculated from daily distance and elapsed days.
- The feedback text was tweaked for clarity, a small wording fix rather than a functional change.
- Deployment and project setup were put in place, including a GitHub Actions workflow for publishing to GitHub Pages plus Dependabot and Copilot configuration files.

---

## succession

- The month was dominated by automated database refreshes from the audit workflow, with `data/succession_dump.sql` updated repeatedly and the SQLite database kept in sync; these appear to be routine data maintenance changes rather than functional code work.
- There was a small CI/configuration update to GitHub Actions, bumping `actions/upload-artifact` from v6 to v7 in the audit and container build workflows.
- No substantive application features, bug fixes, refactoring, or documentation changes are evident in the March log.

---

## tiobe-perl

- Added an automated TIOBE data updater script and GitHub Actions workflow, introducing scheduled data refreshes for the project.
- Tidied repository housekeeping by adding a `.gitignore` and removing an accidentally committed `__pycache__` file.
- Updated the TIOBE data for March 2026 in the documentation data set.
- Adjusted the update schedule so the data job now runs at 03:00 UTC.

---

