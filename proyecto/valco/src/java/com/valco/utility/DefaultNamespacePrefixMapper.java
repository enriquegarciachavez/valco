/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.valco.utility;

import com.sun.xml.bind.marshaller.NamespacePrefixMapper;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author Karla
 */
public class DefaultNamespacePrefixMapper extends NamespacePrefixMapper {

    private Map<String, String> namespaceMap = new HashMap<>();

    public DefaultNamespacePrefixMapper() {
        namespaceMap.put("http://www.w3.org/2001/XMLSchema-instance", "xsi");
        namespaceMap.put("http://www.sat.gob.mx/cfd/3", "cfdi");
        namespaceMap.put("http://www.sat.gob.mx/Pagos", "pago10");
    }

    @Override
    public String getPreferredPrefix(String namespaceUri, String suggestion, boolean requirePrefix) {
        return namespaceMap.getOrDefault(namespaceUri, suggestion);
    }

}
