package com.bitcamp.night.store.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bitcamp.night.store.model.Store;
import com.bitcamp.night.store.service.StoreUpdateService;

@Controller
public class StoreUpdateController {

   // 같은 type을 찾아서 주입
   @Autowired
   private StoreUpdateService storeUpdateService;

   @RequestMapping(value="/store/storeUpdate", method = RequestMethod.GET)
   public String storeUpdate(@RequestParam(value = "store_id") int store_id, Model model, HttpServletRequest request) {

      
      Store stores = storeUpdateService.selectById(store_id);

      model.addAttribute("stores", stores);
      System.out.println(stores);
      
      return "pages/store/storeUpdate";   
   }

   @RequestMapping(value="/store/storeUpdate", method = RequestMethod.POST)
   public String storeUpdate(Store store, Model model, HttpServletRequest request, @RequestParam("store_name") String store_name){

      System.out.println("스토어 : " + store);
      System.out.println("스토어 dd: " + store_name);
      
      int resultCnt = storeUpdateService.storeUpdate(store, request);
      
      String msg = "수정이 완료되었습니다.";

      if (resultCnt == 0) {
         msg = "수정이 되지 않았습니다. 담당자에게 문의 해주세요.";

      }
      model.addAttribute("msg", msg);

      return "pages/store/storeUp";
   }
/*
   @ExceptionHandler(IOException.class)
   public String ex1(IOException e) {
      return "error/ex1";
   }

   @ExceptionHandler(IllegalStateException.class)
   public String ex2(IllegalStateException e) {
      return "error/ex2";
   }*/

}