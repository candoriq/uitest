CREATE TABLE public.departments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    name text NOT NULL,
    constraint departments_pkey primary key (id)
);

CREATE TABLE public.jobs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    name text DEFAULT ''::text NOT NULL,
    department_id uuid NOT NULL,
    constraint jobs_pkey primary key (id),
    constraint jobs_department_id_fkey foreign key (department_id) references departments (id)
);

CREATE DOMAIN public.email AS TEXT
CHECK (VALUE ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');

CREATE TABLE public.employees (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    salary numeric DEFAULT '0'::numeric NOT NULL,
    bonus numeric DEFAULT '0'::numeric NOT NULL,
    equity numeric DEFAULT '0'::numeric NOT NULL,
    start_date date NOT NULL,
    manager_id uuid,
    email public.email,
    department_id uuid NOT NULL,
    job_id uuid NOT NULL,
    user_api_id uuid,
    constraint employees_pkey primary key (id),
    constraint employees_department_id_fkey foreign key (department_id) references departments (id),
    constraint employees_job_id_fkey foreign key (job_id) references jobs (id),
    constraint employees_manager_id_fkey foreign key (manager_id) references employees (id)
);

ALTER TABLE public.employees OWNER TO postgres;
ALTER TABLE public.departments OWNER TO postgres;
ALTER TABLE public.jobs OWNER TO postgres;