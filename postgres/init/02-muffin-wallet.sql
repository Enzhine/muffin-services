\c muffin_wallet_db

create extension if not exists "uuid-ossp";

create schema if not exists muffin_wallet authorization muffin_wallet_user;

grant usage, create on schema muffin_wallet to muffin_wallet_user;

revoke all on schema public from public;

alter default privileges for role muffin_wallet_user in schema muffin_wallet
  grant select, insert, update, delete on tables to muffin_wallet_user;

alter default privileges for role muffin_wallet_user in schema muffin_wallet
  grant usage, select, update on sequences to muffin_wallet_user;
