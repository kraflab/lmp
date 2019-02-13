module LMP
  module ExplainStatistics
    extend self

    def call
      puts <<~EOF
        Statistics:

        General Demo Format Info:
          The lmp format stores player inputs, which can be read by the engine
          later on and played back. These inputs include run, strafe, and turn,
          as well as events such as holding the fire key or pressing use.
          Input is not stored as "Holding down W" but as "Forward = 50",
          which indicates that the player was trying to run forward.
          It does not mean that the player was actually running forward: they
          could be blocked by a monster or a wall, or could even be on the
          intermission screen. The context itself is not stored in the demo.
          Mouse movement can produce for instance a forward value of 1, and
          turbo can give values above 50, so the whole range in general is
          reachable. Similar rules apply for strafing and turning.

        Straferun Frequency:
          This is the percent of movement frames where the player was
          straferunning. Movement means run or strafe was nonzero.
          The list of frequencies for strafe and run is the fraction of
          movement frames where that nonzero value was input by the player.
          Running speed is 50, while walking is 25. Intermediate values are
          possible via mouse movement.

        Turn Frequency:
          The list of turn frequencies is the fraction of turning frames where
          that nonzero value was input by the player. Turning means the turn
          value was nonzero. A 180 degree turn corresponds to a value of 128.

        Average Turn Speed:
          This is the average absolute value of the turn input, ignoring frames
          without turning. The standard deviation is also provided, which
          indicates how spread out the turn speed values are.

        Turbo:
          A frame with run > 50 or strafe > 50 is using turbo, which can be
          achieved via the command line. Any demo using turbo must be marked
          as such, or else the run is suspect.

        Stroller:
          A stroller run must have zero strafe on all frames, as well as no
          frames with a run value over 25.

        SR50 On Turns:
          Maintaining sr50 (run = 50 and strafe = 50) while turning is
          impossible to input under normal circumstances, and any demo
          exhibiting this input is necessarily tool-assisted.

        One Frame Uses:
          This is the number of times a use key was held for a single frame.
          This is possible in normal play and cannot be considered suspect,
          unless the fraction compared to all use frames is high.

        One Frame Fires:
          This is the same as One Frame Uses, but for firing.

        One Frame Swaps:
          This is the same as One Frame Uses, but for weapon swaps.

        Pauses:
          Number of times the demo was paused while recording. This does not
          capture the opening of the menu.

        Saves:
          Number of times the player saved the game while recording the demo.
          This has nothing to do with loading or segmenting. It does indicate
          that the player exited to the menu while recording.

        One Frame Turns:
          A one frame turn is a series of turn values 0, x, 0, where x is
          nonzero. This can be achieved in normal play, so is not suspect
          in itself. High values may be suspect, but depend on sensitivity and
          on the player. Values under 10 are not reported at all.

        Sudden Turns:
          A sudden turn is a series of turn values 0, x or x, 0, where x is
          a high nonzero value. This indicates a sudden jump to or fall from a
          high turn value. Like one frame turns, these are possible during
          normal play, will depend on sensitivity, and values under 10 are not
          reported. In practice, it is more likely to end abruptly than to start
          abruptly. A sudden turn *could* indicate a point of segmenting, if the
          demo is joined mid-turn, or if the player is turning while hitting the
          join key. However, it is not definitive in any way.

        Bad Straferun:
          When trying to execute SR50, the player can accidentally give strafe
          inputs below 50 (for instance, if using the mouse to strafe). This
          stat reports the instances this happens, for each strafe value.
          The total cost is in units of SR50 and is an estimate based on the
          vector of straferun input on the bad frames.
      EOF
    end
  end
end
