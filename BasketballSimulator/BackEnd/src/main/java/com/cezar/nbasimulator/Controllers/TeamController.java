package com.cezar.nbasimulator.Controllers;

import com.cezar.nbasimulator.Entities.Team;
import com.cezar.nbasimulator.Services.TeamServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class TeamController {
    @Autowired
    private TeamServices teamServices;

    @GetMapping("/findTeams")
    public ResponseEntity<List<Team>> findTeams(){
        return new ResponseEntity<>(
                teamServices.showTeams(),
                HttpStatus.OK
        );
    }
    @GetMapping("/findTeam/{name}")
    public ResponseEntity<Team> findTeam(@PathVariable(name = "name") String name){
        return new ResponseEntity<>(
                teamServices.findTeam(name),
                HttpStatus.FOUND
        );
    }
    }

