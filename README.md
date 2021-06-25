# README

Mission management system

![image](https://user-images.githubusercontent.com/73519611/123459176-868ed980-d618-11eb-80df-afeaf5a51a67.png)
## Mission-List Website Link

[Here](https://mission-list-0401.herokuapp.com/)

## Ruby & Rails Version

- Ruby: 2.7.0
- Rails: 6.0.3

## Database
- PostgreSQL 11

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

- Tags

  | Column   | Data Type |
  | -------- | --------- |
  | id       | _bigint_  |
  | label    | _string_  |

- Missions_Tags

  | Column   | Data Type |
  | -------- | --------- |
  | id       | _bigint_  |
  |mission_id     | _ingeter_  |
  | tag_id    |  _ingeter_ |

## Getting Started
1. `$ rails db:create` 
2. `$ rails db` 
3. `$ rails db:migrate` 
4. `$ rails server`
5. visit `localhost:3000`
6. deault account: email: `admin@task.list` password: `123123`

### Development

- Set up Git hook

```sh
$ bundle exec overcommit --install
```
#### Gem  
|Name|Useage|
|----|----|
| Ruboco |  [Ruby guidelines](https://rubystyle.guide/) |
|  Travis CI | Continuous Integration  |
| Ransack | Search feature|
| Kaminari | Pagination |
| Bcrypt | Password encryption |
| Factory_bot | Rspec Helper |
| Faker | Fake information |

