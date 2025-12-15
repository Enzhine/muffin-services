create role muffin_wallet_user login password 'muffin_wallet';

create database muffin_wallet_db owner muffin_wallet_user;
