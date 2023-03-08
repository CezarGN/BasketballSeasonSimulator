package com.cezar.nbasimulator.Controllers;

import com.cezar.nbasimulator.Entities.Game;
import com.cezar.nbasimulator.Entities.Team;
import com.cezar.nbasimulator.Services.GameServices;
import com.cezar.nbasimulator.Services.TeamServices;
import com.cezar.nbasimulator.dto.GameDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
public class GameController {
    @Autowired
    private GameServices gameServices;
    @Autowired
    private TeamServices teamServices;
    static int counter = 0;

    @PostMapping ("/startGame")
    public ResponseEntity<String> startGame(){
        gameServices.deleteGames();
        teamServices.deleteWinsAndLoses();
        counter = 0;
        return new ResponseEntity<>(
                "Game started",
                HttpStatus.CREATED
        );

    }
    @PostMapping("/playGame")
    public ResponseEntity<Game> playGame(){
        if(counter >= 306)
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        return new ResponseEntity<>(
                gameServices.playGame(gameServices.getSchedule().get(counter).getIdteam1(), gameServices.getSchedule().get(counter++).getIdteam2()),
                HttpStatus.CREATED
                );
    }

    @PostMapping("/playSeason")
    public ResponseEntity<List<Game>> playSeason(){
        for(int i = counter; i < gameServices.getSchedule().size(); i++) {
            gameServices.playGame(gameServices.getSchedule().get(i).getIdteam1(), gameServices.getSchedule().get(i).getIdteam2());
        }
        counter = 306;
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @GetMapping("/showGames")
    public ResponseEntity<List<Game>> showGames(){
        return new ResponseEntity<>(
                gameServices.findAll(),
                HttpStatus.OK
        );
    }

    @PostMapping("/playPlayoff")
    public ResponseEntity<Team> playPlayoff(){
        return new ResponseEntity<>(
                gameServices.playPlayoff(),
                HttpStatus.OK
        );
    }
}
