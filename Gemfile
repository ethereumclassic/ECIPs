source "https://rubygems.org"

# Hello! This is where you manage which Jekyll version is used to run.
# When you want to use a different version, change it below, save the
# file and run `bundle install`. Run Jekyll with `bundle exec`, like so:
#
#     bundle exec jekyll serve
#
# This will help ensure the proper Jekyll version is running.
# Happy Jekylling!
gem "jekyll", ">= 3.6.3"
gem "nokogiri", ">= 1.10.8"

# This is the default theme for new Jekyll sites. You may change this to anything you like.
gem "minima", "~> 2.0"

# If you want to use GitHub Pages, remove the "gem "jekyll"" above and
# uncomment the line below. To upgrade, run `bundle update github-pages`.
# gem "github-pages", group: :jekyll_plugins

# If you have any plugins, put them here!
group :jekyll_plugins do
  gem "jekyll-feed", "~> 0.6"
  gem "github-pages", ">= 207"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Performance-booster for watching directories on Windows
gem "wdm", "~> 0.1.0" if Gem.win_platform?

gem "html-proofer", '>=3.3.1'

# Local ECIP validator (replaces external ecip_validator gem)
gem 'front_matter_parser', '~> 0.1.1'
gem 'rake'

# Held below 2.0: sawyer (via octokit) requires faraday (> 0.8, < 2.0).
# 1.10.6 is the lowest release in the maintained 1.x line clearing both
# CVE-2026-25765 (SSRF, fixed 1.10.5) and CVE-2026-54297 (recursion DoS, fixed
# 1.10.6). Both advisories declare `introduced: 1.0.0`, so neither range covers
# the 0.x line the old pin resolved to. Read that as never backported, not as
# unaffected: 0.x is end-of-life at 0.17.6 and carries both defects. It is the
# worse of the two on the SSRF, where 1.10.6 rejects a protocol-relative String
# host but not a URI object (CVE-2026-33637, declared against 2.x only) and
# 0.17.6 rejects neither.
# `~> 1.10.6` rather than `~> 1.10`, which would re-admit 1.10.0 through 1.10.5.
# Original 0.17.3 pin: https://github.com/ethereumclassic/ECIPs/pull/308#issuecomment-618044919
gem 'faraday', '~> 1.10.6'
