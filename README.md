# Jekyll Scheduler

> Jekyll Scheduler is a bash script (executed preferably by CircleCI nightly triggers) that schedule your posts.

Requires a that you Jekyll repository has a [CircleCI environment](https://z3nth10n.net/en/2019/03/20/jekyll-plugin-issue-with-github-pages) set.

## Setup steps

0. Clone this repo outside of your Jekyll site.
	- `git clone https://github.com/uta-org/jekyll-scheduler.git`
1. Create a `sch.ini` file, with this configuration:

```ini
schedule_date=<date in YYYY-MM-DD format>
schedule_post=<url to your posts>
```

*Example:*

```ini
schedule_date=2019-03-31
schedule_post=2019-03-31-how-schedule-posts-in-jekyll.md
schedule_date=2019-03-31
schedule_post=2019-03-31-configuring-custom-domains-github-pages-part-1.md
```

3. Create a "script" folder on your site root path.
	- `mkdir script`
2. Copy this script and the `ini` file into "script" folder.
	- `cp sch.ini <path to your jekyll site>/script/sch.ini && cp get_scheduled_posts.sh <path to your jekyll site>/script/get_scheduled_posts.sh`
4. Create a folder called "schedule" inside "_posts" folder (**Note:** there will be the scheduled posts)
	- `cd _posts && mkdir schedule`
5. Copy this on your `circle.yml` configuration file:

```yaml
defaults: &defaults
    working_directory: ~/repo
    
version: 2
jobs:
	# Your jobs here... 
    schedule_posts:
        <<: *defaults
        docker:
          - image: circleci/ruby:2.6.0-node
        filters:
            branches:
                only:
                  - gh-pages-ci
                ignore:
                  - master
        steps:
            - run:
                name: Executing scheduler
                command: bash ~/repo/script/get_scheduled_posts.sh
workflows:
    version: 2
    test-deploy:
        jobs:
            - schedule_posts
```

6. Enjoy!

## Issues

Having issues? Just report in [the issue section](/issues). **Thanks for the feedback!**

## Contribute

Fork this repository, make your changes and then issue a pull request. If you find bugs or have new ideas that you do not want to implement yourself, file a bug report.

## Donate

Become a patron, by simply clicking on this button (**very appreciated!**):

[![](https://c5.patreon.com/external/logo/become_a_patron_button.png)](https://www.patreon.com/z3nth10n)

... Or if you prefer a one-time donation:

[![](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://paypal.me/z3nth10n)

## Copyright

Copyright (c) 2019 z3nth10n (United Teamwork Association).

License: GNU General Public License v3.0