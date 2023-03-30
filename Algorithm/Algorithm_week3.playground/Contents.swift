//
//// https://school.programmers.co.kr/learn/courses/30/lessons/118669
//// 등산코스 정하기
//
//import Foundation
//
//// Dijkstra
//func solution(_ n:Int, _ paths:[[Int]], _ gates:[Int], _ summits:[Int]) -> [Int] {
//
//    struct Node {
//        let current: Int
//        let maxIntensity: Int
//    }
//
//    var answer = [Int.max, Int.max]
//    var connection: [Int: [[Int]]] = [:] // 0: [[1, 3], [x, w]] // (key -> x, weight: w)
//    var summitDict: [Int: Bool] = [:]
//    var gateDict: [Int: Bool] = [:]
//    var queue: [Node] = []
//    var intensities = [Int](repeating: Int.max, count: n + 1) // 초기 각 점으로 가는 비용은 충분히 큰 값으로 설정
//
//    summits.forEach { summitDict[$0] = true }
//
//    gates.forEach {
//        gateDict[$0] = true
//        queue.append(Node(current: $0, maxIntensity: -1)) // queue 에 gates 삽입.
//    }
//
//    paths.forEach {
//        connection[$0[0], default: []].append([$0[1], $0[2]]) // connection dictionary value 가 비어있는 경우, 초기 값을 [] 로 설정 후 경로 추가.
//        connection[$0[1], default: []].append([$0[0], $0[2]])
//    }
//
//    func updateAnswer(_ index: Int, _ maxIntensity: Int) {
//        if maxIntensity == answer[1] { // Intensity 같은 경우 summit 낮은 값으로 설정
//            answer[0] = min(answer[0], index)
//        } else if maxIntensity < answer[1] { // 새로운 intensity가 더 작을 경우 answer 초기화
//            answer = [index, maxIntensity]
//        }
//    }
//
//    func checkNodes(from node: Node) {
//        if summitDict[node.current] != nil { return } // 현재 node 가 summit -> return
//
//        for next in connection[node.current]! { //  next: [destination, weight]. 모든 점은 연결되어있으므로 force unwrap.
//            if gateDict[next[0]] != nil { continue } // 이동하는 위치가 gate -> skip
//            let maxIntensity = max(node.maxIntensity, next[1]) // 현재 node 의 maxIntensity, 이동할 곳의 weight
//
//            if maxIntensity < intensities[next[0]] {
//                intensities[next[0]] = maxIntensity
//                queue.append(Node(current: next[0], maxIntensity: maxIntensity)) // queue 에 최단경로 삽입
//
//                if summitDict[next[0]] != nil { // summit 인 경우 업데이트
//                    updateAnswer(next[0], maxIntensity)
//                }
//            }
//        }
//    }
//
//    func bfs() {
//        while !queue.isEmpty {
//            let first = queue.removeFirst()
//            checkNodes(from: first)
//        }
//    }
//
//    bfs()
//
//    return answer
//}
//
//
////
////func summitTest() {
////    var summitDict: [Int: Bool] = [:]
////    var gateDict: [Int: Bool] = [:]
//////    var queue: [Node] = []
//////    var intensities = [Int](repeating: Int.max, count: n + 1)
////    let summits = [1,2,3]
////
//////    summitDict = summits.forEach { summitDict[$0] = true }
////
////    for summit in summits {
////        summitDict[summit] = true
////    }
////
////    for gate in gates {
////        gateDict[gate] = true
////    }
////}
////solution(6,    [[1, 2, 3], [2, 3, 5], [2, 4, 2], [2, 5, 4], [3, 4, 4], [4, 5, 3], [4, 6, 1], [5, 6, 1]],    [1, 3],    [5])


import Foundation

class TreeNode {
    var value: Int?
    var left: TreeNode?
    var right: TreeNode?
}

func solution(_ info:[Int], _ edges:[[Int]]) -> Int {
    var numOfPreys = 0
    var numOfPredators = 0
    var connections: [Int:[Int]] = [:]
    var preySet = Set<Int>()
    var predatorSet = Set<Int>()
    
    // info   0: prey, 1: predator,
    for (idx, element) in info.enumerated() {
        element == 1 ? predatorSet.insert(idx) : preySet.insert(idx)
    }
    
    var visited = Array(repeating: false, count: info.count)
    for edge in edges {
        connections[edge[0], default: []].append(edge[1])
        connections[edge[1], default: []].append(edge[0])
    }
    
//    print("connections: \(connections)")
    
    
    
    return 0
}

solution([0,0,1,1,1,0,1,0,1,0,1,1], [[0,1],[1,2],[1,4],[0,8],[8,7],[9,10],[9,11],[4,3],[6,5],[4,6],[8,9]])
