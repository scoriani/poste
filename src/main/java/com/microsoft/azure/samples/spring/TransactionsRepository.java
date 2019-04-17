/*
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See LICENSE in the project root for
 * license information.
 */

package com.microsoft.azure.samples.spring;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import java.sql.Types;


@Repository
public class TransactionsRepository {

    private static final String SQL_FIND_BY_CODE = "SELECT TOP 1 * FROM transactions WHERE code = CONVERT(char(38),:code)";
    private static final String SQL_FIND_ALL = "SELECT * FROM transactions";
    private static final String SQL_INSERT = "UPDATE transactions SET obj_codes_by=:obj_codes_by, part_aggregate=:part_aggregate WHERE code=CONVERT(char(38),:code)";
    private static final String SQL_DELETE_BY_ID = "DELETE FROM PET WHERE ID = :id";

    private static final BeanPropertyRowMapper<Transaction> ROW_MAPPER = new BeanPropertyRowMapper<>(Transaction.class);

    @Autowired
    NamedParameterJdbcTemplate jdbcTemplate;

    public Transaction findByCode(String code) {
        try {
            final SqlParameterSource paramSource = new MapSqlParameterSource().addValue("code", code,Types.CHAR);
            return jdbcTemplate.queryForObject(SQL_FIND_BY_CODE, paramSource, ROW_MAPPER);
        }
        catch (EmptyResultDataAccessException ex) {
            return null;
        }
    }

    public Iterable<Transaction> findAll() {
        return jdbcTemplate.query(SQL_FIND_ALL, ROW_MAPPER);
    }

    public int save(Transaction trn) {
        final SqlParameterSource paramSource = new MapSqlParameterSource()
                .addValue("code", trn.getcode())
                .addValue("obj_codes_by", trn.getobj_codes_by())
                .addValue("part_aggregate", trn.getpart_aggregate());

        return jdbcTemplate.update(SQL_INSERT, paramSource);
    }

    public void deleteByCode(String code) {
        final SqlParameterSource paramSource = new MapSqlParameterSource("code", code);
        jdbcTemplate.update(SQL_DELETE_BY_ID, paramSource);
    }
}

