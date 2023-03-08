package com.cezar.nbasimulator.Services;

import ch.qos.logback.core.joran.sanity.Pair;
import com.cezar.nbasimulator.Entities.Game;
import com.cezar.nbasimulator.Entities.Team;
import com.cezar.nbasimulator.dto.GameDTO;
import lombok.Getter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.cezar.nbasimulator.repositories.GameRepository;
import com.cezar.nbasimulator.repositories.TeamRepository;

import java.lang.reflect.Array;
import java.util.*;
import java.util.stream.Collectors;

@Service
@Getter
public class GameServices {
    @Autowired
    private GameRepository gameRepository;
    @Autowired
    private TeamRepository teamRepository;
    Random random = new Random();

    private ArrayList<GameDTO> gamesDTOS = new ArrayList<GameDTO>();
    //TODO: Implement with Graphs

    private Team higherRating(Team team1, Team team2){
        if(team1.getRating()>team2.getRating())
            return team1;
        return team2;
    }
    private Team lowerRating(Team team1, Team team2){
        if(team1.getRating()<team2.getRating())
            return team1;
        return team2;
    }
    private void decideWinner(Team winner, Team loser, Game newgame) {
        newgame.setWinner(winner);
        winner.setWins(winner.getWins() + 1);
        loser.setLoses(loser.getLoses() + 1);
        teamRepository.save(winner);
        teamRepository.save(loser);
    }
    public Game playGame(Long idteam1, Long idteam2){

        Team team1 = teamRepository.findById(idteam1).get();
        Team team2 = teamRepository.findById(idteam2).get();
        return playGame(team1,team2);
    }
    private Game playGame(Team team1, Team team2) {
        Game newgame = new Game();
        newgame.setTeam1(team1);
        newgame.setTeam2(team2);
        if (Math.abs(team1.getRating() - team2.getRating()) <= 5) {

            if (random.nextInt(0,100) <= 50) {
                decideWinner(team2, team1, newgame);
            } else {
                decideWinner(team1, team2, newgame);
            }
        } else if (Math.abs(team1.getRating() - team2.getRating())>=5 &&
                Math.abs(team1.getRating() - team2.getRating())<=15)  {
            if(random.nextInt(0,100)>=40){
               decideWinner(higherRating(team1,team2),lowerRating(team1,team2),newgame);
            }
            else decideWinner(lowerRating(team1,team2), higherRating(team1,team2), newgame);
        } else if(Math.abs(team1.getRating() - team2.getRating())>=15 &&
                Math.abs(team1.getRating() - team2.getRating())<=20) {
            if(random.nextInt(0,100)>=30)
            decideWinner(higherRating(team1,team2),lowerRating(team1,team2),newgame);
            else decideWinner(lowerRating(team1,team2), higherRating(team1,team2), newgame);
        }
        else if(Math.abs(team1.getRating() - team2.getRating())>=20 &&
                Math.abs(team1.getRating() - team2.getRating())<=30) {
            if (random.nextInt(0, 100) >= 20)
                decideWinner(higherRating(team1, team2), lowerRating(team1, team2), newgame);
            else decideWinner(lowerRating(team1, team2), higherRating(team1, team2), newgame);
        }
        gameRepository.save(newgame);
        return newgame;
    }
    public List<Game> findAll() {
        return gameRepository.findAll();
    }

    public GameDTO setup() {
        Random random = new Random();
        GameDTO gameDTO = new GameDTO();
        Long id1 = random.nextLong(1l,19l);
        Long id2 = random.nextLong(1l,19l);
        gameDTO.setIdteam1(id1);
        gameDTO.setIdteam2(id2);
        while(id1==id2 || gamesDTOS.contains(gameDTO)) {
            id2 = random.nextLong(1l,19l);
            id1 = random.nextLong(1l, 19l);
            gameDTO.setIdteam2(id2);
            gameDTO.setIdteam1(id1);
        }
        gamesDTOS.add(gameDTO);
        return gameDTO;
    }
    public void deleteGames(){
         gameRepository.deleteAll();
    }

    public ArrayList<GameDTO> createSchedule(){
        ArrayList<GameDTO> schedule = new ArrayList<>();
        for(long i=1; i<19; i++){
            for(long j=i+1; j<19; j++){
                GameDTO gameDTO = new GameDTO();
                gameDTO.setIdteam1(i);
                gameDTO.setIdteam2(j);
                schedule.add(gameDTO);
                schedule.add(gameDTO);
            }
        }
        Collections.shuffle(schedule);
        return schedule;
    }
    final ArrayList<GameDTO> schedule = createSchedule();

    public Team playPlayoff(){
        List<Team> allTeams = teamRepository.findAll();
        allTeams = allTeams.stream()
                .sorted(Comparator.comparing(Team::getWins).reversed())
                .collect(Collectors.toList());
        ArrayList<GameDTO> firstRoundSchedule = new ArrayList<>();
        int k=0;
        while(k<4){
            GameDTO gameDTO = new GameDTO(allTeams.get(k).getId(),
                    allTeams.get(7-k).getId());
            firstRoundSchedule.add(gameDTO);
            k++;
        }

        k=0;
        List<Team> secondRoundTeams = new ArrayList<>();
        ArrayList<GameDTO> secondRoundSchedule = new ArrayList<>();
        for(int i=0; i<4; i++){
           Game game = playGame(firstRoundSchedule.get(i).getIdteam1(), firstRoundSchedule.get(i).getIdteam2());
           secondRoundTeams.add(game.getWinner());
        }
        while(k<2){
            GameDTO gameDTO = new GameDTO(secondRoundTeams.get(k).getId(), secondRoundTeams.get(3-k).getId());
            secondRoundSchedule.add(gameDTO);
            k++;
        }
        GameDTO finalGame = new GameDTO();
        Game semifinal1 = playGame(secondRoundSchedule.get(0).getIdteam1(), secondRoundSchedule.get(0).getIdteam2());
        finalGame.setIdteam1(semifinal1.getWinner().getId());
        Game semifinal2 = playGame(secondRoundSchedule.get(0).getIdteam1(), secondRoundSchedule.get(0).getIdteam2());
        finalGame.setIdteam2(semifinal2.getWinner().getId());
       Game last = playGame(finalGame.getIdteam1(), finalGame.getIdteam2());
        return last.getWinner();
    }
}
