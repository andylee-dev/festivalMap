package com.oracle.s202350104.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class BoardController {

	private final BoardService boardService;

	@RequestMapping(value = "/freeBoardList")
	public String boardList(Model model) {

		List<Board> freeAllList = boardService.getFreeAllList();
		log.info("controller freeAllList size --> " + freeAllList.size());
		
		model.addAttribute("freeAllList", freeAllList);

		return "board/freeBoardList";
	}
}
