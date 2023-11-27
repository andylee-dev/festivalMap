package com.oracle.s202350104.service.recommand;

import java.util.List;

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