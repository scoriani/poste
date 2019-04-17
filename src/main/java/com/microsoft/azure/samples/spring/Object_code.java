/*
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See LICENSE in the project root for
 * license information.
 */

package com.microsoft.azure.samples.spring;

import org.springframework.data.annotation.Id;

public class Object_code {
     private Integer id;
     private String acceptance_date;

    @Id
    private String code;

    private String dati;

    private String expiration_date;

    private String product_details;

    private String sale_date;
    
    private String status;
    
    private String transactions;

    public Integer getid() {
        return id;
    }

    public void setid(Integer id) {
        this.id = id;
    }

    public String getcode() {
        return code;
    }

    public void setcode(String code) {
        this.code = code;
    }

    public String getacceptance_date() {
        return acceptance_date;
    }

    public void setacceptance_date(String acpdate) {
        this.acceptance_date = acpdate;
    }

    public String getdati() {
        return dati;
    }

    public void setdati(String dati) {
        this.dati = dati;
    }

    public String getexpiration_date() {
        return expiration_date;
    }

    public void setexpiration_date(String expiration_date) {
        this.expiration_date = expiration_date;
    }

    public String getproduct_details() {
        return product_details;
    }

    public void setproduct_details(String product_details) {
        this.product_details = product_details;
    }

    public String getsale_date() {
        return sale_date;
    }

    public void setsale_date(String sale_date) {
        this.sale_date = sale_date;
    }

    public String getstatus() {
        return status;
    }

    public void setstatus(String status) {
        this.status = status;
    }

    public String gettransactions() {
        return transactions;
    }

    public void settansactions(String transactions) {
        this.transactions = transactions;
    }

    @Override
    public String toString() {
        return "Object_code";
    }
}
