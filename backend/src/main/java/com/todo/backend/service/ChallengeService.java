package com.todo.backend.service;

import com.todo.backend.controller.request.ChallengeRequestdto;
import com.todo.backend.entity.ChallengeEntity;
import com.todo.backend.entity.DoType;
import com.todo.backend.repository.ChallengeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;
import java.time.LocalDate;
import java.util.List;

@Service
public class ChallengeService {

    @Autowired
    private ChallengeRepository challengeRepository;

    //ChallengeEntity의 데이터를 리스트로 저장
    public  List<ChallengeEntity> getAllChallenge() {
        return challengeRepository.findAll();
    }
    //ChallengeEntity 데이터 초기화는 enddate에 맞춰서 초기화??

    public ChallengeEntity addChallenge(ChallengeRequestdto challengeRequest) { // 추가
        ChallengeEntity challengeEntity = new ChallengeEntity();
        challengeEntity.setTitle(challengeRequest.getTitle());
        challengeEntity.setContent(challengeRequest.getContent());
        challengeEntity.setMemo(challengeRequest.getMemo());
        challengeEntity.setDotype(DoType.valueOf(challengeRequest.getDotype().toUpperCase()));
        challengeEntity.setStartdate(challengeRequest.getStartdate());
        challengeEntity.setEnddate(challengeRequest.getEnddate());

        return challengeRepository.save(challengeEntity);
    }

    public ChallengeEntity updateChallenge(int id, ChallengeRequestdto challengeRequest) { //수정
        ChallengeEntity challengeEntity = challengeRepository.findById(id)
                //예외처리: 해당 id의 challenge가 없다면
                .orElseThrow(() -> new EntityNotFoundException("Challenge with id " + id + " not found"));
        challengeEntity.setTitle(challengeRequest.getTitle());
        challengeEntity.setContent(challengeRequest.getContent());
        challengeEntity.setMemo(challengeRequest.getMemo());
        challengeEntity.setDotype(DoType.valueOf(challengeRequest.getDotype().toUpperCase()));
        challengeEntity.setEnddate(challengeRequest.getEnddate());
        challengeEntity.setStartdate(challengeRequest.getStartdate());
        challengeEntity.setEnddate(challengeRequest.getEnddate());

        return challengeRepository.save(challengeEntity);
    }

    public void deleteChallenge(int id) {
        challengeRepository.deleteById(id);
    }
    /*public List<ChallengeEntity> getChallengeByDateRange(LocalDate startDate, LocalDate endDate) {
        return challengeRepository.findByStartdateBetweenAndEnddateBetween(startDate.atStartOfDay(), endDate.atTime(23, 59, 59));
    }*/
}
