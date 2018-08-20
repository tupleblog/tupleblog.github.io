# tupleblog

Repository for [tupleblog](http://tupleblog.github.io) (in Thai) based on [Jekyll](http://jekyllrb.com/) [HPSTR](https://github.com/mmistakes/hpstr-jekyll-theme) theme.

### Running the blog locally

First, go to `_config.yml` then change line 9 for running locally. Then, change
directory to the repository and then do the following

  1. run `ruby --version` to check if there is already `ruby` on your system. If there is skip to step 3, else do step 2.
  2. Download `ruby` using [Homebrew](https://brew.sh/) for Mac. For Windows, download **RubyInstaller** and
  **DEVELOPMENT KIT** regarding your OS architecture from [here](https://rubyinstaller.org/downloads/).
  For **RubyInstaller**, just double click and done. For **DEVELOPMENT KIT**, please follows [its instruction](https://github.com/oneclick/rubyinstaller/wiki/Development-Kit).
  3. Update your installed gems to latest version `gem update`. If updating failed try running `gem update --system` to update its core (see [this post](http://guides.rubygems.org/ssl-certificate-update/#installing-using-update-packages)). 
  4. `gem install bundler`
  5. `bundle install` (For Windows, run `cmd` as Administrator)
  6. `bundle exec jekyll serve` to serve the site in port 4000. You can also run
with drafts using `bundle exec jekyll serve --drafts`


### Contribution by Pull Request

- Add your profile to `_data/authors.yml` file. You can put your avatar image in
`images/avatar` folder

- All posts on the website are all located in `_posts` folder where the post name format is `yyyy-mm-dd-post-name.md`. Jekyll uses [markdown](https://guides.github.com/features/mastering-markdown/) format for the post which can be easily written. We can provide header of each post (markdown file) as

```markdown
---
layout: post
title: "Post Title"
author: Titipata (author id from authors.yml)
description: "Short description for the post"
modified: 2014-12-13
tags: [post, title, example]
comments: false (or true if you want people to leave a comment)
---
```

After the header of each post, you can simply write down a post. You can see example
or previous posts in the `_posts` folder


### Members
- [Titipat (My)](http://titipata.github.io)
- [Tulakan Ruangrong (Tul)](https://github.com/bluenex)
- [Kukkik Oparad (Kukkik)](https://github.com/bachkukkik)
- [Kittinan (Tun)](https://github.com/kittinan)
