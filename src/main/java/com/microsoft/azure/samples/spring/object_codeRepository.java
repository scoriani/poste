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


@Repository
public class object_codeRepository {

    private static final String SQL_FIND_BY_CODE = "SELECT * FROM object_code WHERE code = :code";
    private static final String SQL_FIND_BY_CODES = "SELECT * FROM object_code WHERE code IN ";
    //private static final String SQL_FIND_BY_CODES = "SELECT code FROM object_code";

    private static final BeanPropertyRowMapper<Object_code> ROW_MAPPER = new BeanPropertyRowMapper<Object_code>(Object_code.class);

    @Autowired
    NamedParameterJdbcTemplate jdbcTemplate;

    public Object_code findByCode(String code) {
        try {
            final SqlParameterSource paramSource = new MapSqlParameterSource("code", code);
            return jdbcTemplate.queryForObject(SQL_FIND_BY_CODE, paramSource, ROW_MAPPER);
        }
        catch (EmptyResultDataAccessException ex) {
            return null;
        }
    }

    public Iterable<Object_code> findByCodes(String cods) {
           //final SqlParameterSource paramSource = new MapSqlParameterSource("codes", cods);
            
          //  System.out.println(codes);

           Iterable<Object_code> it = jdbcTemplate.query(SQL_FIND_BY_CODES +"(" + cods + ")", ROW_MAPPER);
        //    Iterable<Object_code> it = jdbcTemplate.query(SQL_FIND_BY_CODES, ROW_MAPPER);

            return it;
        }

}

