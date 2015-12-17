# TupleBlog

Repository for [TupleBlog](http://tupleblog.github.io) (in Thai) based on [Jekyll](http://jekyllrb.com/) [HPSTR](https://github.com/mmistakes/hpstr-jekyll-theme) theme.

### Want to write blogs with us?

- If you want to be a member on Github repository, ask [Titipat](https://twitter.com/titipat_a) or [Tulakan](http://twitter.com/tulakann). We can add you to the repository
- Alternative is to create pull request by fork this repository

### Make a contribution

- Add your profile to `_data/authors.yml` file which has some fields such as `name`, `web`, `email`, `twitter`, `avatar`. `avatar` is for blogger image where you can provide an image file name that you can add to the folder `images`

- All posts on the website are all located in `_posts` folder where the post name format is `yyyy-mm-dd-post-name.md` (`.md` stands for markdown). Jekyll uses [markdown](https://guides.github.com/features/mastering-markdown/) format for the post which can be easily written. We can provide header of each post (markdown file) as

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

After the header of each post, you can simply write down a post. You can see example or previous posts in the `_posts` folder

### Using drafts
[Drafts](http://jekyllrb.com/docs/drafts/) is a useful feature of Jekyll. To use drafts, first we don't need the date on file name of the post and second we need to place it in `_drafts` folder. After that you can work with drafts by running Jekyll with flag `--drafts`. This blog uses bundler and normally we run by `bundle exec jekyll serve`, thus if you need to see draft as a latest post you need to run `bundle exec jekyll serve --drafts`.

### Start writing
After cloning repo you can start writing a post. To be able to see how it would look like when served you need to install some of the requirements.

Go to tupleblog repo and run `npm install` to install all required node modules. Then run `bundle install` to install all required gems, and you are good to go. By default we run jekyll by `bundle exec jekyll serve --watch --drafts`, but by now I've included [Gulp to help in live-reloading](https://nvbn.github.io/2015/06/19/jekyll-browsersync/), so to observe how the blog looks like you need to do 2 things.

- go to `_config.yml` and then go to line 9. Do following comments there.
- run `gulp` and the blog is served!

### Members
- [Titipat Achakulvisut (My)](http://titipata.github.io)
- [Tulakan Ruangrong (Tul)](https://github.com/bluenex)
