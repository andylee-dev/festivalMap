package com.oracle.s202350104.service.recommand;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.oracle.s202350104.model.Board;

public class SimilarityUtils {
	
	
    public static double calculatePearsonSimilarity(List<Board> user1Reviews, List<Board> user2Reviews) {
        double sumX = 0, sumY = 0, sumXY = 0;
        double sumX2 = 0, sumY2 = 0;
        int n = 0;

        for (int i = 0; i < user1Reviews.size(); i++) {
            for (int j = 0; j < user2Reviews.size(); j++) {
                if (user1Reviews.get(i).getContent_id() == user2Reviews.get(j).getContent_id()) {
                    n++;
                    double x = user1Reviews.get(i).getScore();
                    double y = user2Reviews.get(j).getScore();
                    
                    sumX += x;
                    sumY += y;
                    sumXY += x * y;
                    sumX2 += Math.pow(x, 2);
                    sumY2 += Math.pow(y, 2);
                }
            }
        }

        if (n == 0) return 0;
        double denominator = Math.sqrt(sumX2 - Math.pow(sumX, 2) / n) * Math.sqrt(sumY2 - Math.pow(sumY, 2) / n);

        if (denominator == 0) return 0;
        else return (sumXY - (sumX * sumY) / n) / denominator;
    }

    public static double calculateCosineSimilarity2(List<Board> user1Reviews, List<Board> user2Reviews) {
        double dotProduct = 0.0;
        double normA = 0.0;
        double normB = 0.0;
        Map<Integer, Integer> user1ReviewsMap = user1Reviews.stream()
                .collect(Collectors.toMap(Board::getContent_id, Board::getScore));
        Map<Integer, Integer> user2ReviewsMap = user2Reviews.stream()
                .collect(Collectors.toMap(Board::getContent_id, Board::getScore));

        for (Integer contentId : user1ReviewsMap.keySet()) {
            Integer user1Score = user1ReviewsMap.get(contentId);
            Integer user2Score = user2ReviewsMap.get(contentId);

            if (user1Score != null && user2Score != null) {
                dotProduct += user1Score * user2Score;
                normA += Math.pow(user1Score, 2);
                normB += Math.pow(user2Score, 2);
            }
        }

        double denominator = Math.sqrt(normA) * Math.sqrt(normB);
        return denominator != 0 ? dotProduct / denominator : 0;
    }

    
    /**
     * 성능 향상을 위해 가장 먼저 고려해보아야 할 점은 calculateCosineSimilarity 메소드 내부의 중첩 루프입니다. 
     * 이 코드는 사용자 리뷰 리스트의 크기를 n, m이라 할 때, 시간 복잡도가 O(nm)인데, 이는 매우 비효율적입니다. 
     * 이를 개선하기 위해, 두 사용자의 리뷰를 빠르게 조회할 수 있는 자료구조를 사용할 수 있습니다.
     * 예를 들어, Map을 사용하여 content_id를 key로, score를 value로 가지는 구조를 만들 수 있습니다. 
     * 이렇게 하면 content_id에 따른 score를 O(1)의 시간 복잡도로 조회할 수 있습니다.
     * 다음은 개선된 calculateCosineSimilarity 메소드의 예시입니다:
     */
    public static double calculateCosineSimilarity(List<Board> user1Reviews, List<Board> user2Reviews) {
        double dotProduct = 0.0;
        double normA = 0.0;
        double normB = 0.0;
        for (int i = 0; i < user1Reviews.size(); i++) {
            for (int j = 0; j < user2Reviews.size(); j++) {
                if (user1Reviews.get(i).getContent_id() == user2Reviews.get(j).getContent_id()) {
                    dotProduct += user1Reviews.get(i).getScore() * user2Reviews.get(j).getScore();
                    normA += Math.pow(user1Reviews.get(i).getScore(), 2);
                    normB += Math.pow(user2Reviews.get(j).getScore(), 2);
                }
            }   
        }   

        double denominator = Math.sqrt(normA) * Math.sqrt(normB);
        return denominator != 0 ? dotProduct / denominator : 0;
    }
}