# Evaluation Instructions

## Prereqs

- Must have npm, git, supabase cli, and docker.

## Overview:

This test is designed to assess your skills using a stack that includes
Supabase, Next.JS, and React. The tasks closely mirror the responsibilities
expected for this role at CandorIQ and will heavily test your system design
abilities.

## Guidelines:

1. **Flexibility:** Feel free to leverage any available resources. Use any of
   the specified technologies, but avoid introducing new ones.

2. **Grading Focus:** The primary focus during grading will be on the
   functionality and quality of your code.

3. **Quality Check:** Before progressing to the next task, ensure a thorough
   quality check of your code. Attention to detail is crucial.

### Supabase Setup

1. Follow supabase setup instructions here =>
   [https://supabase.com/docs/guides/local-development/cli/getting-started](https://supabase.com/docs/guides/local-development/cli/getting-started)
2. To start supabase run `supabase start` in your terminal
3. To run sql migrations and seed the database run `supabase db reset`

### Phase 1

### Setup

1. Install all dependencies by running `npm install`
2. Link the NextJS application to local Supabase by creating a `.env.local` file
   in the root folder and adding the following 2 keys
   - `NEXT_PUBLIC_SUPABASE_URL="http://localhost:64321"`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY="{insert anon key}"` (You can get the anon
     key by running `supabase status`)
3. Run `npm run dev` in your terminal to start your application.
4. Go to [http://localhost:3000/](http://localhost:3000/) in your browser.
5. After completion, submit by email after compressing the folder into a zip
   file.
6. Access the supabase ui [http://localhost:64323/](http://localhost:64323/)

### Task

There are three tables: employees, jobs, and departments. Each employee has a
manager_id that references another employee's record. Currently, logging in from
any account grants visibility of all employee records. Your task is to implement
access control so that each account can view only the employees within their
management hierarchy.

For example, David Anderson should be able to see Alice Johnson, as he is her
manager, and also Jessica White, as Alice is Jessica's manager. However, David
should not be able to see John Doe, who is his own manager and he should not see
himself. Ensure that the access control works correctly for two specific
accounts, David Anderson and Emma Williams. Access shouldn’t be limited only at
UI but also at the API level as Supabase automatically creates API routes for
all tables in the public schema.

### Account Credentials:

1. David Anderson
   - email: david.anderson@example.com
   - password: password123

2. Emma Williams
   - email: emma.williams@example.com
   - password: password123

**Bonus** Each employee is associated with a specific job. Ensure that
each account can view only the jobs linked to the employees they have permission
to access, according to the management hierarchy.

### Phase 2

First, see the docs for creating a new user: [https://supabase.com/docs/reference/javascript/auth-admin-createuser/](https://supabase.com/docs/reference/javascript/auth-admin-createuser)

We will now introduce the concept of a user profile.

Create a new table called user_api to store users and their corresponding profile.
Profile can be one of two options - admin or manager. 
This table should contain the columns:
   - id (foreign key to auth.users)
   - name (string)
   - email (email)
   - profile (enum: admin, manager)

Seed the two given users into the user_api table. Assign the manager profile to David and the admin profile to Emma.

Add a new Users tab in the app’s side panel. This tab should let you:

   - View a list of existing users.
   - Create new users for employees (only employees can become users).
   - Select and create multiple users at once.

When the form is submitted, create the new users and update the corresponding records in the employees table with their newly assigned user IDs. 

**Bonus**

Now, we want to alter the access policies we outlined in the previous phase.

- **Admins**
  - Can view all employees and jobs (no hierarchy restrictions).
  - Have access to the **Users** tab.
  - Can create new users.

- **Managers**
  - Must follow hierarchy-based access rules from Phase 1.
  - No access to the **Users** tab.
  - Cannot create new users.

These rules must be enforced both in the **UI** and at the **API level**.