CREATE TABLE users (
                       username VARCHAR(50) NOT NULL PRIMARY KEY,
                       password VARCHAR(500) NOT NULL,
                       enabled BOOLEAN NOT NULL
);


CREATE TABLE authorities (
                             username VARCHAR(50) NOT NULL,
                             authority VARCHAR(50) NOT NULL,
                             CONSTRAINT fk_authorities_users FOREIGN KEY (username) REFERENCES users(username)
);

CREATE UNIQUE INDEX ix_auth_username ON authorities (username, authority);

INSERT INTO users (username, password, enabled) VALUES
    ('user', '{noop}inorg@12345', '1')
    ON CONFLICT (username) DO NOTHING;

INSERT INTO users (username, password, enabled) VALUES
    ('admin', '{bcrypt}$2a$12$3VdHbUl2ovljuIi3/3D4OOvQ8wMmVM0afCjum4lfzNNe1iUmSw8ce', '1')
    ON CONFLICT (username) DO NOTHING;

INSERT INTO authorities (username, authority) VALUES
    ('user', 'read')
    ON CONFLICT (username, authority) DO NOTHING;

INSERT INTO authorities (username, authority) VALUES
    ('admin', 'admin')
    ON CONFLICT (username, authority) DO NOTHING;


CREATE TABLE customer (
                          id SERIAL PRIMARY KEY,
                          email VARCHAR(45) NOT NULL,
                          pwd VARCHAR(200) NOT NULL,
                          role VARCHAR(45) NOT NULL
);


INSERT INTO customer (email, pwd, role) VALUES
                                            ('happy@example.com', '{noop}cwz@abc', 'read'),
                                            ('admin@example.com', '{bcrypt}$2a$12$3VdHbUl2ovljuIi3/3D4OOvQ8wMmVM0afCjum4lfzNNe1iUmSw8ce', 'admin');