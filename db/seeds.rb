# frozen_string_literal: true
admin = Kf::User.create!(
    display_name: 'Admin',
    email: "admin@kfamv.com",
    password: "123456",
    admin: true
)

user = Kf::User.create!(
    display_name: 'LinuCC',
    email: 'linucc@linu.cc',
    password: "asdf1234"
)

amv_messageboard = Thredded::Messageboard.create!(
    name: 'AMVs',
    slug: 'amvs',
    description: 'The newest and coolest AMVs'
)

messageboard = Thredded::Messageboard.create!(
    name: 'Frontpage',
    slug: 'frontpage',
    description: 'Get updates on all the stuff'
)

animes = [
  Kf::AmvSource.create!(title: 'Tengen Toppa Gurren Laggan'),
  Kf::AmvSource.create!(title: 'Excel Saga'),
  Kf::AmvSource.create!(title: 'Girls und Panzer'),
];

songs = [
  Kf::Song.create!(title: 'Never gonna you up', artist: 'Rick Astley'),
  Kf::Song.create!(title: 'Sandstorm', artist: 'Darude'),
  Kf::Song.create!(title: 'Deja Vu', artist: 'Initial D'),
];

Thredded::TopicForm.new(
    title: 'Here, have some stuff',
    content: <<-MARKDOWN,
Hello **world**! :smile: This first post shows some of the Thredded default post
formatting functionality.

### Quote

> There is nothing either good or bad, but thinking makes it so.

### Image

![lime-cat](https://cloud.githubusercontent.com/assets/216339/19857777/2be75b1e-9f3c-11e6-9845-f30ceb4308a9.jpg)

### Video

https://www.youtube.com/watch?v=dQw4w9WgXcQ

### Table

| x | y | x ⊕ y |
|---|---|:-----:|
| 1 | 1 |   0   |
| 1 | 0 |   1   |
| 0 | 1 |   1   |
| 0 | 0 |   0   |

### Code

```ruby
puts 'Hello world'
```

Code highlighting can be enabled by installing the
[Markdown Coderay plugin](https://github.com/thredded/thredded-markdown_coderay).

BBCode support (e.g. [b]bold[/b]) can be enabled by installing the
[BBCode plugin](https://github.com/thredded/thredded-bbcode).

TeX Math support (e.g. $$\phi$$) can be enabled by installing the
[KaTeX plugin](https://github.com/thredded/thredded-markdown_katex).
    MARKDOWN
    user: admin,
    messageboard: messageboard
).save

amv_post_form = Thredded::TopicForm.new(
    title: 'Hakuna Matata your ratata AMV by xXxAlcoHolicxXx',
    content: <<-MARKDOWN,
Hello Community,

I have finished my *biggest*, most _badass_ AMV yet.
Look at it and be amazed:

https://www.youtube.com/watch?v=2Z4m4lnjxkY

What a masterpiece.
I want to thank my family, friends, cat and my waifu for this great opportunity.

Alco out.
  MARKDOWN
  user: user,
  messageboard: amv_messageboard
)
amv_post_form.save

amv = Kf::AmvPost.create!(
  post: amv_post_form.post, editor_list: "xXxAlcoHolicxXx"
)

amv_post_form2 = Thredded::TopicForm.new(
    title: 'Speeeeedometer',
    content: <<-MARKDOWN,
THE CoNTENXT
  MARKDOWN
  user: user,
  messageboard: amv_messageboard
)
amv_post_form2.save

Kf::AmvPost.create!(
  post: amv_post_form2.post, editor_list: 'Mark Twain, DeineMudda34'
)

