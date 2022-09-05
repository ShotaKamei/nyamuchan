//
//  Sort.swift
//  nyamuchan
//
//  Created by 亀井翔太 on 2022/09/05.
//

import Foundation

struct List{
    var key: Int
    var value2: Int
}

func Sort(_ dlist: Array<Any>) -> Array<Any>{
    var comp:Array<List> = []
    for (i, j) in dlist.enumerated(){
        var k = j as! Dictionary<String,Any>
        comp.append(List(key: i, value2: k["value"] as! Int))
    }
    comp.sort(by: {$0.value2 > $1.value2})
    
    var comp2:Array<Any> = []
    for l in comp{
        comp2.append(dlist[l.key])
    }
    return comp2
}
