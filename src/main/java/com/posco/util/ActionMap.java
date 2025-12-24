package com.posco.util;

import java.util.HashMap;
import java.util.Map;

public class ActionMap {

	Map<String, Object> actionMap = new HashMap<String, Object>();
	
	
	public String getReturnAction(String tagName) {
		String result = "";
		
		int index = tagName.lastIndexOf("");

		String text = tagName.substring(0, index);
		
//		result = actionMap.get(text).toString();

		if(text.contains("alarm")) {
			result = "c";
		}else if(text.contains("yello-left")) {
			result = "b";
		}else if(text.contains("yello-right")) {
			result = "b";
		}else {
			//v는 .val포함
			result = "v";
		}
		
		
		return result;
		
	}	
	
	public String getReturnAction(Map<String, Object> tagInfo) {
	    String tagName = tagInfo.get("tagName").toString();
	    String tagType = tagInfo.get("tagType").toString();
	    String result = "";

	   
	    if("analog".equals(tagType)){
	        return "value";
	    }

	    if(tagName.contains("green-")){
	        return "green";
	    }

	    if(tagName.contains("water-")){
	        return "water";
	    }
	    
	    if(tagName.contains("set-")){
	        return "settext";
	    }
	    
	    if("analog".equals(tagType) || tagName.startsWith("analog-")) {
            return "value";
        }
	    
	    if (tagName.contains("icon-stop") || tagName.contains("icon-reset") || tagName.contains("icon-test")) {
	        return "value";   // 또는 고정 동작
	    }

	    if(tagName.contains("alarm")){
	        result = "c";
	    } else if(tagName.contains("yello-left")) {
	        result = "b";
	    } else if(tagName.contains("yello-right")) {
	        result = "b";
	    } else if(tagName.contains("lamp-text")) {
	        result = "lamp"; 
	    } else if(tagName.contains("lamp-on")) {
	        result = "lamp"; 
	    } else if(tagName.contains("lamp")) {
	        result = "lamp"; 
	    } else if(tagName.contains("lamp-arrow")){
	    	 result = "lamp"; 
	    }
	    else if(tagName.contains("lamp-bit1")) {
	        result = "lamp"; 
	    }
	    else if(tagName.contains("lamp-bit2")) {
	        result = "lamp"; 
	    }
	    else if(tagName.contains("lamp-bit3")) {
	        result = "lamp"; 
	    }
	    else if(tagName.contains("lamp-bit4")) {
	        result = "lamp"; 
	    }
	    else if(tagName.contains("lamp-bit5")) {
	        result = "lamp"; 
	    }
	    else if(tagName.contains("lamp-bit6")) {
	        result = "lamp"; 
	    }
	    else if(tagName.contains("lamp-bit7")) {
	        result = "lamp"; 
	    }
	    else if(tagName.contains("lamp-bit8")) {
	        result = "lamp"; 
	    }
	    else if(tagName.contains("lamp-bit9")) {
	        result = "lamp"; 
	    }
	    else if(tagName.contains("pen")) {
	        return "pen";
	    }else if(tagName.contains("ok")) {
	        return "ok";
	    }
	    else {
	        result = "v";  // 기본 on/off 표시
	    }

	    return result;
	}

	
	
}
