package main

import (
	"bufio"
	"encoding/csv"
	"os"
	"sort"
	"strings"
)

func main() {
	inputFile, err := os.Open(os.Args[1])
	if err != nil {
		panic(err)
	}
	defer inputFile.Close()
	fileScanner := bufio.NewScanner(inputFile)
	writer := csv.NewWriter(os.Stdout)

	for fileScanner.Scan() {
		p := permutations{}
		p.permute([]rune(fileScanner.Text()), 0)
		sort.Sort(p)
		writer.Write(p.strings)
	}
	writer.Flush()
}

type permutations struct {
	strings []string
}

// implements a lexicographic sort.Interface
func (p permutations) Len() int           { return len(p.strings) }
func (p permutations) Less(i, j int) bool { return strings.Compare(p.strings[i], p.strings[j]) == -1 }
func (p permutations) Swap(i, j int)      { p.strings[i], p.strings[j] = p.strings[j], p.strings[i] }

// permute sequence at index
func (p *permutations) permute(sequence []rune, index int) {
	if index > len(sequence) {
		p.strings = append(p.strings, string(sequence))
		return
	}
	p.permute(sequence, index+1)
	for next := index + 1; next < len(sequence); next++ {
		sequence[index], sequence[next] = sequence[next], sequence[index]
		p.permute(sequence, index+1)
		sequence[index], sequence[next] = sequence[next], sequence[index]
	}
}
