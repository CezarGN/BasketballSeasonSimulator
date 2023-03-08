package com.cezar.nbasimulator.Services;

import com.cezar.nbasimulator.Entities.Team;
import com.cezar.nbasimulator.repositories.TeamRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TeamServices {
    @Autowired
    private TeamRepository teamRepository;

    public List<Team> showTeams(){
        return teamRepository.findAll();
    }

    public Team findTeam(String name){
        return teamRepository.findTeamByName(name);
    }

    public void deleteWinsAndLoses(){
        for(long i=1; i<19; i++){
            Team team = teamRepository.findById(i).get();
            team.setWins(0);
            team.setLoses(0);
            teamRepository.save(team);
        }
    }
}
