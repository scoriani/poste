/*
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See LICENSE in the project root for
 * license information.
 */

package com.microsoft.azure.samples.spring;

import org.springframework.data.annotation.Id;

public class Transaction {
    private Integer id;

    @Id
    private String code;

    private String obj_codes_by;

    private String part_aggregate;

    private Iterable<Object_code> codes;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getcode() {
        return code;
    }

    public void setcode(String code) {
        this.code = code;
    }

    public String getobj_codes_by() {
        return obj_codes_by;
    }

    public void setobj_codes_by(String objcodes) {
        this.obj_codes_by = objcodes;
    }

    public String getpart_aggregate() {
        return part_aggregate;
    }

    public void setpart_aggregate(String parts) {
        this.part_aggregate = parts;
    }

    public Iterable<Object_code> getCodes() {
         return codes;
     }

     public void setCodes(Iterable<Object_code> codes) {
         this.codes = codes;
     }


    // @Override
    // public String toString() {
    //     return "Transaction{" +
    //             "code=" + code +
    //             ", obj_codes_by='" + obj_codes_by + '\'' +
    //             ", part_aggregate='" + part_aggregate + '\'' +
    //             '}';
    // }
}
