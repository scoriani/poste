package com.microsoft.azure.samples.spring;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

import com.microsoft.applicationinsights.TelemetryClient;
import com.microsoft.applicationinsights.telemetry.Duration;

import org.json.JSONArray;
import org.json.JSONObject;

@Controller
@RequestMapping(path="/transactions")
public class TransactionsController {
    @Autowired
    private TransactionsRepository transactionsRepository;

    @Autowired
    private object_codeRepository objRepository;

    @Autowired
     TelemetryClient telemetryClient;


    @PostMapping
    public @ResponseBody String createTransaction(@RequestBody Transaction trn) {
        
        long start = System.nanoTime();

        transactionsRepository.save(trn);

        long finish = System.nanoTime();
        long timeElapsed = finish - start;

        Duration d = new Duration(timeElapsed/1000000);

        telemetryClient.trackDependency("SQL", "Update", d, true);

        return String.format("Updated: %s mS", d.getMilliseconds());
    }

    @GetMapping
    public @ResponseBody Iterable<Transaction> getAllTransactions() {
        return transactionsRepository.findAll();
    }

    @GetMapping("/sda/{code}")
    public @ResponseBody Optional<Transaction> getTransactionSDA(@PathVariable String code) {

        long start = System.nanoTime();

        Transaction trn = transactionsRepository.findByCode(code);

        String unescaped = trn.getobj_codes_by().replace("\\","");  

        JSONObject obj = new JSONObject(unescaped);

        String key = obj.names().opt(0).toString();

        JSONArray codes = obj.getJSONArray(key).getJSONObject(0).getJSONArray("objcods");

        String codestr = "";

        for (int i = 0; i < codes.length(); i++) {
            codestr = codestr + "'" + codes.getJSONObject(i).getString("code") +"',";
        }

        codestr = codestr.substring(0, codestr.length()-1);

        Iterable<Object_code> res = objRepository.findByCodes(codestr);
 
        System.out.println(codestr);

        trn.setCodes(res);

        long finish = System.nanoTime();
        long timeElapsed = finish - start;

        Duration d = new Duration(timeElapsed/1000000);

        telemetryClient.trackDependency("SQL", "Select", d, true);

        return Optional.ofNullable(trn);
    }

    @GetMapping("/{code}")
    public @ResponseBody Optional<Transaction> getTransaction(@PathVariable String code) {

        long start = System.nanoTime();

        Transaction trn = transactionsRepository.findByCode(code);

        // String unescaped = trn.getobj_codes_by().replace("\\","");  

        // JSONObject obj = new JSONObject(unescaped);

        // String key = obj.names().opt(0).toString();

        // JSONArray codes = obj.getJSONArray(key).getJSONObject(0).getJSONArray("objcods");

        // String codestr = "";

        // for (int i = 0; i < codes.length(); i++) {
        //     codestr = codestr + "'" + codes.getJSONObject(i).getString("code") +"',";
        // }

        // codestr = codestr.substring(0, codestr.length()-1);

        // Iterable<Object_code> res = objRepository.findByCodes(codestr);
 
        // System.out.println(codestr);

        // trn.setCodes(res);

        long finish = System.nanoTime();
        long timeElapsed = finish - start;

        Duration d = new Duration(timeElapsed/1000000);

        telemetryClient.trackDependency("SQL", "Select", d, true);

        return Optional.ofNullable(trn);
    }

}
