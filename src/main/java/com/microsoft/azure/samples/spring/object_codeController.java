/*
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See LICENSE in the project root for
 * license information.
 */

package com.microsoft.azure.samples.spring;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

import com.microsoft.applicationinsights.TelemetryClient;
import java.io.IOException;
import com.microsoft.applicationinsights.telemetry.Duration;

@Controller
@RequestMapping(path="/object_code")
public class object_codeController {
    @Autowired
    private object_codeRepository obj_codeRepository;

    @Autowired
     TelemetryClient telemetryClient;

    @GetMapping("/{code}")
    public @ResponseBody Optional<Object_code> getTransaction(@PathVariable String code) {

        long start = System.nanoTime();

        //track a custom dependency

        Object_code trn = obj_codeRepository.findByCode(code);

        long finish = System.nanoTime();
        long timeElapsed = finish - start;

        Duration d = new Duration(timeElapsed/1000000);

        telemetryClient.trackDependency("SQL", "Select", d, true);

        return Optional.ofNullable(trn);
    }

}
