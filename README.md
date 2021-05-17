# README

model

- schema
  [ERD](https://lucid.app/lucidchart/invitations/accept/inv_891a8c39-ff82-4cfc-b75c-4f3c438283bd?viewport_loc=-72%2C-277%2C1707%2C780%2C0_0)

  - missions

    - id: bigint
    - title: string
    - sort: integer
    - status: string
    - context: text
    - tag: string
    - start: datetime
    - end: datetime
    - user_id : bigint

  - user

    - id: bigint
    - name: string
    - email: string
    - password: string
