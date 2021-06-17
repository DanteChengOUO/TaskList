# README

Mission management system

## Mission-List Website Link

[Here](https://mission-list-0401.herokuapp.com/)

## Ruby & Rails Version

- Ruby: 2.7.0
- Rails: 6.0.3

## Heroku deployment

### Stack

- Heroku 18

### App on Heroku

1. Create a Heroku account
2. Install Heroku CLI
   `curl https://cli-assets.heroku.com/install-ubuntu.sh | sh` ( updated manually )
3. `heroku create <path>` ( Heroku will name for you if you dont' set it )
4. `git push heroku master`
5. `heroku run bundle`
6. `heroku run rails db:migrate`
7. visit `https://<path>.herokuapp.com/`

## ER Diagram

- schema
  Refer to docs/ERD.png for a copy of [ERD](https://lucid.app/lucidchart/invitations/accept/inv_891a8c39-ff82-4cfc-b75c-4f3c438283bd?viewport_loc=-72%2C-277%2C1707%2C780%2C0_0).

## Table Schema

- missions

  | Column     | Data Type  |
  | ---------- | ---------- |
  | id         | _bigint_   |
  | title      | _string_   |
  | content    | _text_     |
  | started_at | _datetime_ |
  | ended_at   | _datetime_ |
  | user_id    | _bigint_   |

- Users

  | Column   | Data Type |
  | -------- | --------- |
  | id       | _bigint_  |
  | name     | _string_  |
  | email    | _string_  |
  | password | _string_  |

## Getting Started

### Development

- TODO: add rundown for development

- Set up Git hook

```sh
$ bundle exec overcommit --install
```
